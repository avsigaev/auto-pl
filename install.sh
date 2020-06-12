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

github_url='https://raw.githubusercontent.com/sonm-io/fan-control'

if ! [[ -z $1 ]]; then
	branch=$1
else
	branch='master'
fi

if [[ -f /usr/bin/sonm-fan-control.sh ]]; then
	rm /usr/bin/sonm-fan-control.sh
	rm /usr/bin/sonm-xorg-config.sh
	rm /etc/sonm/fan-control.txt
fi

wget -q ${github_url}/${branch}/fan-control.cfg -O /etc/sonm/fan-control.cfg
wget -q ${github_url}/${branch}/sonm-xorg-config.service -O /etc/systemd/system/sonm-xorg-config.service
wget -q ${github_url}/${branch}/sonm-fan-control.service -O /etc/systemd/system/sonm-fan-control.service
wget -q ${github_url}/${branch}/sonm-fan-control -O /usr/bin/sonm-fan-control
wget -q ${github_url}/${branch}/sonm-xorg-config -O /usr/bin/sonm-xorg-config

chmod +x /usr/bin/sonm-fan-control
chmod +x /usr/bin/sonm-xorg-config

echo Enabling service
systemctl daemon-reload
systemctl enable sonm-fan-control.service
systemctl enable sonm-xorg-config.service
systemctl restart sonm-mon.service
systemctl restart sonm-fan-control.service

echo Done
