# py

sudo apt-get update && sudo apt-get upgrade -y

git clone https://github.com/miftahfaridhh/py.git
cd py
sudo chmod u+x py.sh
// Password
./py.sh

sudo reboot now


# vnc default


mkdir -p ~/.config/autostart
cp /usr/share/applications/vino-server.desktop ~/.config/autostart/.
cd /usr/lib/systemd/user/graphical-session.target.wants
sudo ln -s ../vino-server.service ./.
gsettings set org.gnome.Vino prompt-enabled false
gsettings set org.gnome.Vino require-encryption false
gsettings set org.gnome.Vino authentication-methods "['vnc']"
gsettings set org.gnome.Vino vnc-password $(echo -n 'wicomai'|base64)

cd ~

sudo apt-get install ufw -y

sudo cp -r /usr/lib/python3/dist-packages/ufw /opt/python/3.10.13/lib/python3.10/site-packages


sudo ufw enable
sudo ufw allow 5900
sudo ufw status

# tightvnc

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