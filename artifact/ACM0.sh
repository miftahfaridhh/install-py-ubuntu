
sudo nano /usr/local/bin/chmod-ttyACM.sh




#!/bin/bash

for i in {0..9}; do
    if [ -e /dev/ttyACM$i ]; then
        chmod 666 /dev/ttyACM$i
    fi
done


sudo chmod +x /usr/local/bin/chmod-ttyACM.sh


sudo nano /etc/systemd/system/chmod-ttyACM.service


[Unit]
Description=Set permissions for /dev/ttyACM* devices
After=multi-user.target

[Service]
Type=oneshot
ExecStart=/usr/local/bin/chmod-ttyACM.sh
RemainAfterExit=true

[Install]
WantedBy=multi-user.target


sudo systemctl daemon-reload

sudo systemctl enable chmod-ttyACM.service
sudo systemctl start chmod-ttyACM.service



//////Different Only One/////

sudo nano /etc/systemd/system/chmod-ttyACM0.service


[Unit]
Description=Set permissions for /dev/ttyACM0
After=dev-ttyACM0.device
Requires=dev-ttyACM0.device

[Service]
Type=oneshot
ExecStart=/bin/chmod 666 /dev/ttyACM0
RemainAfterExit=true

[Install]
WantedBy=multi-user.target


sudo systemctl daemon-reload


sudo systemctl enable chmod-ttyACM0.service


sudo systemctl start chmod-ttyACM0.service
