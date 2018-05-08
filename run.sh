#!/bin/bash

echo -e "$VNC_PASSWD\n$VNC_PASSWD\n\n" | vncpasswd

sed -i '/xterm/s/^/#/' /root/.vnc/xstartup
sed -i '/twm/s/^/#/' /root/.vnc/xstartup
sed -i '$a gnome-session &' /root/.vnc/xstartup
sed -i '$a VNCSERVERS="1:root"' /etc/sysconfig/vncservers
sed -i '$a VNCSERVERARGS[1]="-geometry 1024x768 -alwaysshared -depth 24"' /etc/sysconfig/vncservers

vncserver

sleep 999999