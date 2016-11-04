#!/bin/bash

if [[ "$UID" != "0" ]]; then
    echo "Please run this script as root"
    exit 1
fi

# Install Pip for installation of Compose later on
apt-get -qy update && apt-get -qy install python-pip

# Install Docker itself, we use this script because it works
curl -sSL https://get.docker.com | sh

# We use docker-compose from Pip because it is up to date
pip install docker-compose

# Installing the raspi-cluster service
ln -s $(pwd) /srv/raspi-cluster
cp raspi-cluster.service /etc/systemd/system
systemctl daemon-reload
systemctl start raspi-cluster.service
systemctl enable raspi-cluster.service
