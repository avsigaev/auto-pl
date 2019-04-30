#!/usr/bin/env bash

if [[ "$(id -u)" != "0" ]]; then
   echo "This script must be run as superuser"
   exit 1
fi

if ! lspci -nm | grep '"\(0300\|0302\)" "10de"' 2>&1 >/dev/null; then
    echo "No NVIDIA cards detected"
    exit 0
fi

nvidia-xconfig --allow-empty-initial-configuration --enable-all-gpus --cool-bits=4 --separate-x-screens
