#!/bin/bash -x

sudo tee /usr/bin/vnccopypaste.sh > /dev/null << EOF
vncconfig -nowin &
EOF

sudo chmod +x /usr/bin/vnccopypaste.sh

sudo tee /etc/xdg/autostart/vnccopypaste.desktop > /dev/null << EOF
[Desktop Entry]
Type=Application
Name=VNC Copy Paste
Exec=/usr/bin/vnccopypaste.sh
Icon=system-run
X-GNOME-Autostart-enabled=true
EOF
