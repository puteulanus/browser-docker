#!/bin/bash

echo -e "$VNC_PASSWD\n$VNC_PASSWD\n\n" | vncpasswd

mkdir -p mkdir /root/.vnc/
echo 'openbox-session' >  /root/.vnc/xstartup
chmod +x /root/.vnc/xstartup

rm -f /tmp/.X11-lock

vncserver -kill :1
vncserver :1 -geometry 1024x768 -alwaysshared -depth 24

scl enable rh-python36 'python init.py' &

supervisord -nc /etc/supervisord.conf