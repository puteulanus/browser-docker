#!/bin/bash

echo -e "$VNC_PASSWD\n$VNC_PASSWD\n\n" | vncpasswd

if [ ! -d /etc/vnc ]; then
    mkdir /etc/vnc
fi

echo 'openbox-session' > /etc/vnc/xstartup

if [ -f /tmp/.X11-lock ]; then
    rm -f /tmp/.X11-lock
fi

vncserver
supervisord -c /etc/supervisord.conf

sleep 999999