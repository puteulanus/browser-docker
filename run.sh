#!/bin/bash

echo -e "$VNC_PASSWD\n$VNC_PASSWD\n\n" | vncpasswd

if [ ! -d /root/.vnc/ ]; then
    mkdir /root/.vnc/
fi

echo 'openbox-session' >  /root/.vnc/xstartup

if [ -f /tmp/.X11-lock ]; then
    rm -f /tmp/.X11-lock
fi

vncserver -kill :1
vncserver :1
supervisord -c /etc/supervisord.conf

chromium-browser --no-sandbox