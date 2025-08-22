#!/bin/sh -x

# install xubuntu-desktop and fix root login error
export DEBIAN_FRONTEND=noninteractive
sudo apt-get update
sudo apt-get install -y xubuntu-desktop
sudo sed -i 's/mesg n || true.*/tty -s \&\& mesg n || true/g' /root/.profile
