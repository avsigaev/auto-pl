#!/usr/bin/env bash

# Exit script as soon as a command fails.
set -o errexit

if [ -z $(echo $(pgrep Xorg)) ]; then
    echo 'ERROR: Xorg server is not running, exit'
    # exit 1
fi

github_url='https://raw.githubusercontent.com/avsigaev/fan-control'
branch='master'

wget -q ${github_url}/${branch}/fan-control.txt -O /etc/sonm/fan-control.txt
wget -q ${github_url}/${branch}/sonm-fan.service -O /etc/systemd/system/sonm-fan.service
wget -q ${github_url}/${branch}/fan-control.sh -O /usr/bin/fan-control.sh

systemctl daemon-reload
systemctl enable sonm-fan.service
systemctl restart sonm-fan.service

echo Done