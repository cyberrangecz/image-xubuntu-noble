#!/bin/bash -x

# reset cloud-init
sudo rm -rf /var/lib/cloud/
sudo rm -f /etc/cloud/cloud-init.disabled
sudo rm -f /etc/netplan/*
sudo rm -f /etc/machine-id

# cleanup
sudo apt-get -y autoremove
sudo apt-get -y autoclean
sudo rm -rf /var/log
