#!/usr/bin/env bash

if [ -z $(pgrep Xorg) ]; then
    echo 'ERROR: Xorg server is not running, exit'
    exit 1
fi

export $(cat /etc/sonm/fan-control.txt)

for GPU in $(nvidia-smi -L | awk  '{print $2}' | tr -d ':'); do
    echo "GPU index $GPU"
    echo $(DISPLAY=:0 nvidia-settings -a [gpu:$GPU]/GPUFanControlState=1 -a [fan:$GPU]/GPUTargetFanSpeed=$FAN_SPEED)
done

