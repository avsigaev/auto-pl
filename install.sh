#!/usr/bin/env bash

# Exit script as soon as a command fails.
set -o errexit

if [[ "$(id -u)" != "0" ]]; then
   echo "This script must be run as superuser"
   exit 1
fi

github_url='https://raw.githubusercontent.com/avsigaev/auto-pl'

if ! [[ -z $1 ]]; then
	branch=$1
else
	branch='master'
fi

wget -q ${github_url}/${branch}/auto-pl.cfg -O /etc/sonm/auto-pl.cfg
wget -q ${github_url}/${branch}/auto-pl.service -O /etc/systemd/system/auto-pl.service
wget -q ${github_url}/${branch}/auto-pl -O /usr/bin/auto-pl

chmod +x /usr/bin/auto-pl

echo Enabling service
systemctl daemon-reload
systemctl enable auto-pl.service
systemctl restart auto-pl.service

echo Done
