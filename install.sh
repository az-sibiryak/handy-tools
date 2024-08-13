#!/bin/bash

#
# Name:         install.sh
# Version:      1.0.0
#
# (c) 2024, alexey.mcmlxxi@gmail.com
#

export PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin

[ -d "/usr/local/bin" ] || mkdir -vp "/usr/local/bin" || exit 1

for _f in \
    "az-iperf" \
    "az-mtr"   \
; do
    cp -vp "${_f}" "/usr/local/bin/${_f}"
    chmod -v 0755 "/usr/local/bin/${_f}"
done
