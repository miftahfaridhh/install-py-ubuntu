sudo nano /home/nano/.vnc/xstartup

#!/bin/bash
unset SESSION_MANAGER
unset DBUS_SESSION_BUS_ADDRESS
xrdb $HOME/.Xresources
startxfce4 &

vncserver :1 -geometry 1920x1080


sudo nano /etc/systemd/system/vncserver@.service

[Unit]
Description=Start TightVNC server at startup
After=syslog.target network.target

[Service]
Type=forking
User=nano
Group=nano
WorkingDirectory=/home/nano

PIDFile=/home/nano/.vnc/%H:%i.pid
ExecStartPre=-/usr/bin/vncserver -kill :%i > /dev/null 2>&1
ExecStart=/usr/bin/vncserver -depth 24 -geometry 1920x1080 :%i
ExecStop=/usr/bin/vncserver -kill :%i

[Install]
WantedBy=multi-user.target

sudo systemctl daemon-reload

sudo systemctl enable vncserver@1.service

vncserver -kill :1

sudo systemctl start vncserver@1

