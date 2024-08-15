#!/bin/bash

# ------------------------------------------------------------------------------------------ #
#
# Name:         handy-tools.lib.sh
# Version:      1.0.1
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


# ----------------------------------------------------------------- #
# --                                                             -- #
# --                 GLOBAL VARIABLES                            -- #
# --                                                             -- #
# ----------------------------------------------------------------- #

# -- TERM dimensions
max_lines="$( tput lines )"
max_lines="$(( max_lines - 3 ))"
max_columns="$( tput cols )"
export max_lines max_columns


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


# ----------------------------------------------------------------- #
# --                                                             -- #
# --                     FUNCTIONS                               -- #
# --                                                             -- #
# ----------------------------------------------------------------- #

# -- Echo the backtitle string in form 'Backtitle ... spaces ... [SC_VER]'
_backtitle () {
    local v_len
    local t_len
    local n_spaces
    local bt

    bt="${SC_NAME} ${SC_VER}: ${1}"

    t_len="$( wc -c <<< "${bt}" )"
    v_len="$( wc -c <<< "${SC_VER}" )"
    n_spaces="$(( max_columns - t_len - v_len ))"

    printf "%s%${n_spaces}s%s" "${bt}" " " "${SC_VER}"
}

_dialog_msgbox () {
    local t="${1}"                  # box title 
    local b="${2}"                  # backtitle
    local m="${3}"                  # box content
    local bt

    dialog \
        ${DIALOG_OPTS} \
        --aspect 14 \
        --title "   ${t}   " \
        --backtitle "$( _backtitle "${b}" )" \
        --scrollbar \
        --msgbox "${m}" \
        0 0

    return 0
}

_dialog_infobox () {
    local t="${1}"                  # box title 
    local b="${2}"                  # backtitle
    local m="${3}"                  # box content
    local bt

    dialog \
        ${DIALOG_OPTS} \
        --aspect 14 \
        --title "   ${t}   " \
        --backtitle "$( _backtitle "${b}" )" \
        --infobox "${m}" \
        0 0

    return 0
}

_dialog_please_wait () {
    local t="${1}"                  # box title 
    local b="${2}"                  # backtitle
    local bt

    _dialog_infobox "${t}" "${b}" "\n      Please wait      \n\n"

    return 0
}

_dialog_textbox () {
    local t="${1}"                  # box title 
    local b="${2}"                  # backtitle
    local m="${3}"                  # box content

    echo -e "${m}" | expand > "${TEXT}"

    dialog \
        ${DIALOG_OPTS} \
        --aspect 14 \
        --title "   ${t}   " \
        --backtitle "$( _backtitle "${b}" )" \
        --exit-label "OK" \
        --scrollbar \
        --textbox "${TEXT}" \
        0 0

    return 0
}


# -- Return formatted date string for logs
_log_tstamp () {
    date -u +"%d-%m-%Y %T %Z" 2> /dev/null
}



# =========================================================== #
#                                                             #
# ==            MAIN (executable) SECTION                  == #
#                                                             #
# =========================================================== #

HOSTNAME="$( hostname )"
export HOSTNAME
