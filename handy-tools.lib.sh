#!/bin/bash

# ------------------------------------------------------------------------------------------ #
#
# Name:         handy-tools.lib.sh
# Version:      1.0.0
#
# (c) 2024, alexey.mcmlxxi@gmail.com
#
# License:      GNU General Public License 3.0
#               https://www.gnu.org/licenses/gpl-3.0.html
#
# ------------------------------------------------------------------------------------------ #

export LANG="en_US"

__sc_full_path="$( readlink -f "${0}" )"
SC_NAME="$( basename "${__sc_full_path}" )"
SC_DIR="$( dirname "${__sc_full_path}" )"
[ -z "${SC_VER}" ] \
    && SC_VER="$( grep -m 1 -E '^#\s*Version:\s+' "${0}" | awk '{print $NF}' )"
SC_PID="$$"

LIB_NAME="$( basename "$( readlink -f "${BASH_SOURCE[0]}" )" )"
LIB_DIR="$( dirname "$( readlink -f "${BASH_SOURCE[0]}" )" )"
LIB_VER="$( grep -m 1 -E '^#\s*Version:\s+' "${BASH_SOURCE[0]}" | awk '{print $NF}' )"
export LIB_NAME
export LIB_DIR
export LIB_VER

# --
# -- `dialog` exit status codes
# --
DIALOG_OK=0
DIALOG_CANCEL=1
DIALOG_HELP=2
DIALOG_EXTRA=3
DIALOG_ITEM_HELP=4
DIALOG_ESC=255
DIALOG_OPTS="--ascii-lines --no-collapse --colors"

# --
# -- Log file
# --
export LOG_DIR="/var/log/app-mgr"
if [ ! -d "${LOG_DIR}" ] ; then
    if ! mkdir -p "${LOG_DIR}" ; then
        >&2 echo "ERROR: Can't create ${LOG_DIR} directory! Aborting..."
        exit 1
    fi
fi
export LOG_FILE="${LOG_DIR}/${SC_NAME}.log"

# --
# -- State dir (database and other stuff)
# --
export STATE_DIR="/var/local/app-mgr"
if [ ! -d "${STATE_DIR}" ] ; then
    if ! mkdir -p "${STATE_DIR}" ; then
        >&2 echo "ERROR: Can't create ${STATE_DIR} directory! Aborting..."
        exit 1
    else
        chown -R root:root "${STATE_DIR}" &> /dev/null
        chmod -R 0750 "${STATE_DIR}" &> /dev/null
    fi
fi
export DB_DIR="${STATE_DIR}/db"
if [ ! -d "${DB_DIR}" ] ; then
    if ! mkdir -p "${DB_DIR}" ; then
        >&2 echo "ERROR: Can't create ${DB_DIR} directory! Aborting..."
        exit 1
    else
        chown -R root:root "${DB_DIR}" &> /dev/null
        chmod -R 0750 "${DB_DIR}" &> /dev/null
    fi
fi
export DB_NAME="app-mgr.db"
export DB_TEMPLATE_NAME="app-mgr.template.db"
export DB="${DB_DIR}/${DB_NAME}"
export DB_TEMPLATE="${DB_DIR}/${DB_TEMPLATE_NAME}"

# --
# -- Check if another operation is in progress
# --
LOCK_FILE="/var/lock/app-mgr.lock"

if [ "${APPMGR_LOCK}" = "yes" ] ; then
    if ! flock -w 0.1 "${LOCK_FILE}" echo "" &> /dev/null ; then
        >&2 echo "ERROR: Another operation is in progress!"
        _sc_name="$( awk -F'|' '{print $1}' "${LOCK_FILE}" )"
        _sc_pid="$(  awk -F'|' '{print $2}' "${LOCK_FILE}" )"
        _sc_start_time="$(  awk -F'|' '{print $3}' "${LOCK_FILE}" )"
        _sc_start_time_hr="$( date -d "@${_sc_start_time}" -u )"
        >&2 echo "${_sc_name} [PID: ${_sc_pid}]: Running since ${_sc_start_time_hr}"
        exit 100
    fi
fi

# --
# -- Check OS vendor/version
# --
LSB_VENDOR="n/a"
LSB_RELEASE="n/a"
LSB_VER="n/a"
LSB_FULL_VERSION="n/a"
LSB_CODENAME="n/a"
LSB_DESCRIPTION="n/a"
LSB_OSFAMILY="n/a"
if command -v lsb_release &> /dev/null ; then
    LSB_VENDOR="$( lsb_release -si )"
    LSB_RELEASE="$( lsb_release -sr )"
    LSB_CODENAME="$( lsb_release -sc )"
    LSB_DESCRIPTION="$( lsb_release -sd \
                            | sed -e 's/^\"\(.*\)\"$/\1/' \
                            | sed -e 's/^[[:space:]]*//' \
                            | sed -e 's/[[:space:]]*$//' \
                      )"
    LSB_FULL_VERSION="${LSB_RELEASE}"
elif [ -e "/etc/os-release" ] ; then
    . "/etc/os-release"
    [ -n "${NAME}" ]             && LSB_VENDOR="${NAME}"
    [ -n "${VERSION_ID}" ]       && LSB_RELEASE="${VERSION_ID}"
    [ -n "${VERSION}" ]          && LSB_FULL_VERSION="$( awk '{print $1}' <<< "${VERSION}" )"
    [ -n "${VERSION_CODENAME}" ] && LSB_CODENAME="${VERSION_CODENAME}"
    [ -n "${PRETTY_NAME}" ]      && LSB_DESCRIPTION="${PRETTY_NAME}"
    if [ "${LSB_VENDOR}" = "Ubuntu" ] ; then
        case "${LSB_RELEASE}" in
          "14.04")
              LSB_CODENAME="trusty"
              ;;
        esac
    fi
    [ "${LSB_FULL_VERSION}" = "n/a" ] && LSB_FULL_VERSION="${LSB_RELEASE}"
elif [ -e "/etc/redhat-release" ] ; then
    LSB_VENDOR="$( awk '{print $1}' "/etc/redhat-release" )"
    LSB_RELEASE="$( \
          sed -re 's/^.* release ([0-9.]*).*$/\1/' < "/etc/redhat-release" \
              | awk -F'.' '{print $1}' )"
    LSB_CODENAME="n/a"
    LSB_DESCRIPTION="$( < "/etc/redhat-release" )"
    LSB_FULL_VERSION="$( sed -re 's/^.* release ([0-9.]*).*$/\1/' < "/etc/redhat-release" )"
else
    >&2 echo "ERROR: Can't determine OS vendor/version! Aborting..."
    exit 1
fi
export LSB_VENDOR
export LSB_RELEASE
export LSB_VER
export LSB_FULL_VERSION
export LSB_CODENAME
export LSB_DESCRIPTION

# --
# -- Check OS family
# --
case "${LSB_VENDOR,,}" in
  "centos")
      LSB_OSFAMILY="redhat"
      ;;
  "debian"|"devuan"|"ubuntu")
      LSB_OSFAMILY="debian"
      ;;
esac
export LSB_OSFAMILY

case "${LSB_OSFAMILY}" in
  "debian")
      export DEBIAN_FRONTEND="noninteractive"
      ;;
  "redhat")
      ;;
  *)
      >&2 echo "ERROR: Can't run on ${LSB_VENDOR} ${LSB_RELEASE}! Aborting..."
      exit 1
      ;;
esac


# --
# -- Return formatted date string for logs
# --
_log_tstamp () {
    date -u +"%d-%m-%Y %T %Z" 2> /dev/null
}


# --
# -- Prepare RedHat-based environment
# --
_prep_redhat () {
    local _rc=0
    return ${_rc}
}


# --
# -- Prepare Debian-based environment
# --
_prep_debian () {
    local _rc=0
    local _key

    declare -A __debian_utils
    # -- Key == oommand, value == package
    __debian_utils=( \
          ["apt-add-repository"]="software-properties-common" \
          ["bzip2"]="bzip2" \
          ["curl"]="curl" \
          ["dialog"]="dialog" \
          ["dig"]="dnsutils" \
          ["flock"]="util-linux" \
          ["git"]="git-core" \
          ["hostname"]="hostname" \
          ["ping"]="iputils-ping" \
          ["sqlite3"]="sqlite3" \
          ["vim"]="vim" \
          ["wget"]="wget" \
        )
    for _key in ${!__debian_utils[@]} ; do
        if ! command -v "${_key}" &> /dev/null ; then
            echo -e "${_key}:\tNOT found! Trying to install..."
            if    apt-get -y -qq update \
               && apt-get -y -qq \
                          -o Dpkg::Options::='--force-confdef' \
                      install "${__debian_utils[${_key}]}"
            then
                echo "Done."
            else
                >&2 echo "ERROR: Can't install '${__debian_utils[${_key}]}'! Aborting..."
                exit 1
            fi
#        else
#            echo -e "${_key}:\tFound ==> ${__debian_utils["${_key}"]}"
        fi
    done
  # vvvvvvvvvvvvvvvvvvvvvvvvv FIXME vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
  if false ; then
    # --
    # -- Check if we have `nginx` package
    # --
    if    dpkg -s 'nginx' &> /dev/null \
       && dpkg -s 'php-fpm' &> /dev/null
    then
        echo "nginx, php: OK"
    else
        echo -e "nginx, php:\tNOT found! Trying to install..."
        if    apt-get -y -qq update \
           && apt-get -y -qq \
                      -o Dpkg::Options::='--force-confdef' \
                  install "nginx" "php-fpm"
            then
                echo "Done."
            else
                >&2 echo "ERROR: Aborting..."
                exit 1
            fi
    fi
  fi
  # ^^^^^^^^^^^^^^^^^^^^^^^^^ /FIXME ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

    return ${_rc}
}


# --
# -- Prepare environment
# --
_prep_env () {
    local _rc=0

    # -- Prepare running environment for the determined LSB_OSFAMILY
    _prep_${LSB_OSFAMILY}

    return ${_rc}
}


# --
# -- FIXME
# --
SCRIPTENTRY () {
    local _rc=0
    return ${_rc}
}


# --
# -- FIXME
# --
SCRIPTEXIT () {
    local _rc=0
    return ${_rc}
}



# =========================================================== #
#                                                             #
# ==            MAIN (executable) SECTION                  == #
#                                                             #
# =========================================================== #

HOSTNAME="$( hostname )"
export HOSTNAME

# == Prepare running environment
_prep_env



