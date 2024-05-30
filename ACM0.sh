//////Different Only One/////

sudo nano /etc/systemd/system/chmod-ttyACM0.service


[Unit]
Description=Set permissions for /dev/ttyACM0
After=dev-ttyACM0.device
Requires=dev-ttyACM0.device

[Service]
Type=oneshot
ExecStart=/bin/chmod 666 /dev/ttyACM0 /dev/ttyACM1
RemainAfterExit=true

[Install]
WantedBy=multi-user.target


sudo systemctl daemon-reload


sudo systemctl enable chmod-ttyACM0.service


sudo systemctl start chmod-ttyACM0.service
