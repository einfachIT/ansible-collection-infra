#!/bin/bash

raspi-config nonint do_wayland W3
raspi-config nonint do_vnc_resolution 1920x1080
raspi-config nonint do_vnc 0

cat <<'EOF' >/etc/wayvnc/config
use_relative_paths=true
address=::
enable_auth=false
enable_pam=false
username=epic
password=epic
EOF

reboot
