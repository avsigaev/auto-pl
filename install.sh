#!/usr/bin/env bash

# Exit script as soon as a command fails.
set -o errexit

if [ -z $(pgrep Xorg) ]; then
    echo 'ERROR: Xorg server is not running, exit'
    exit 1
else 
    echo 'Xorg is running, OK'
fi

github_url='https://raw.githubusercontent.com/avsigaev/fan-control'
branch='master'

wget -q ${github_url}/${branch}/fan-control.txt -O /etc/sonm/fan-control.txt
wget -q ${github_url}/${branch}/sonm-fan.service -O /etc/systemd/system/sonm-fan.service
wget -q ${github_url}/${branch}/fan-control.sh -O /usr/bin/fan-control.sh

chmod +x /usr/bin/fan-control.sh

echo Enabling service
systemctl daemon-reload
systemctl enable sonm-fan.service
systemctl restart sonm-fan.service

echo Done