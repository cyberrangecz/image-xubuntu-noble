#!/bin/sh -x

# install xubuntu-desktop and fix root login error
export DEBIAN_FRONTEND=noninteractive
sudo apt-get update
sudo apt-get install -y xubuntu-desktop
sudo sed -i 's/mesg n || true.*/tty -s \&\& mesg n || true/g' /root/.profile

# fix authentication is required to create a color managed device popup
sudo tee /etc/polkit-1/rules.d/45-allow-colord.rules > /dev/null << EOF
polkit.addRule(function(action, subject) {
    if (action.id.indexOf("org.freedesktop.color-manager.") == 0) {
        return polkit.Result.YES;
    }
});
EOF
