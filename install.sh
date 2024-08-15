#!/bin/bash

#
# Name:         install.sh
# Version:      1.0.1
#
# (c) 2024, alexey.mcmlxxi@gmail.com
#
# License:      GNU General Public License 3.0
#               https://www.gnu.org/licenses/gpl-3.0.html
#

export PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin

[ -d "/usr/local/bin" ] || mkdir -vp "/usr/local/bin" || exit 1
[ -d "/usr/local/lib" ] || mkdir -vp "/usr/local/lib" || exit 1

for _f in \
    "az-iperf" \
    "az-mtr"   \
; do
    cp -vp "${_f}" "/usr/local/bin/${_f}" || exit 1
    chmod -v 0755 "/usr/local/bin/${_f}" || exit 1
done

for _f in \
    "handy-tools.lib.sh" \
; do
    cp -vp "${_f}" "/usr/local/lib/${_f}" || exit 1
done

exit 0
