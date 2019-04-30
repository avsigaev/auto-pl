#!/usr/bin/env bash

# Exit script as soon as a command fails.
set -o errexit

if [[ "$(id -u)" != "0" ]]; then
   echo "This script must be run as superuser"
   exit 1
fi

if [ -z $(which sonmmon) ]; then
    echo 'ERROR: SONM Monitor not detected'
    exit 1
fi

github_url='https://raw.githubusercontent.com/avsigaev/fan-control'
branch='master'

wget -q ${github_url}/${branch}/fan-control.txt -O /etc/sonm/fan-control.txt
wget -q ${github_url}/${branch}/sonm-xorg-config.service -O /etc/systemd/system/sonm-xorg-config.service
wget -q ${github_url}/${branch}/sonm-fan-control.service -O /etc/systemd/system/sonm-fan-control.service
wget -q ${github_url}/${branch}/sonm-fan-control.sh -O /usr/bin/sonm-fan-control.sh
wget -q ${github_url}/${branch}/sonm-xorg-config.sh -O /usr/bin/sonm-xorg-config.sh

chmod +x /usr/bin/sonm-fan-control.sh
chmod +x /usr/bin/sonm-xorg-config.sh

echo Enabling service
systemctl daemon-reload
systemctl enable sonm-fan-control.service
systemctl enable sonm-xorg-config.service
systemctl restart sonm-mon.service
systemctl start sonm-fan-control.service

echo Done