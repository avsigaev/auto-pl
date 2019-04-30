#!/usr/bin/env bash

if [[ "$(id -u)" != "0" ]]; then
   echo "This script must be run as superuser"
   exit 1
fi

if ! lspci -nm | grep '"\(0300\|0302\)" "10de"' 2>&1 >/dev/null; then
    echo "No NVIDIA cards detected"
    exit 0
fi

export $(cat /etc/sonm/fan-control.txt)

for GPU in $(nvidia-smi -L | awk  '{print $2}' | tr -d ':'); do
    echo "GPU index $GPU"
    echo $(DISPLAY=:0 nvidia-settings -a [gpu:$GPU]/GPUFanControlState=1 -a [fan:$GPU]/GPUTargetFanSpeed=$FAN_SPEED)
done
