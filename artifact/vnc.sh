https://github.com/overclock98/Jetson_Nano_true_Headless_setup_without_hdmi_display/blob/main/README.md


mkdir -p ~/.config/autostart
cp /usr/share/applications/vino-server.desktop ~/.config/autostart/.
cd /usr/lib/systemd/user/graphical-session.target.wants
sudo ln -s ../vino-server.service ./.
gsettings set org.gnome.Vino prompt-enabled false
gsettings set org.gnome.Vino require-encryption false
gsettings set org.gnome.Vino authentication-methods "['vnc']"
gsettings set org.gnome.Vino vnc-password $(echo -n 'wicomai'|base64)


Jetson Nano Headless Setup
1.	Download image file from Nvidia website
2.	Extract and write to micro mmc with etcher
3.	Select dc power supply with jumper
4.	Insert mmc to nano
5.	Connect barrel power supply (5v,3a) to nano
6.	Connect micro usb cable between pc and nano
7.	Wait for com port appear
8.	Open com port with putty (board rate: 115200)
9.	Accept and proceed
10.	Select primary interface as dummy0 (Wi-Fi will configure later)
11.	Choose “do not configure network at this time” and proceed
12.	Login with password
13.	Insert wifi dongle in to usb port
14.	Check dongle with “nmcli d”
15.	Turn on the wifi “nmcli r wifi on”
16.	List out wifi “nmcli d wifi list”
17.	Enter ssid and password “sudo nmcli d wifi connect my_wifi password <password>”
18.	Check ip with  “ifconfig wlan0”
19.	Reboot and login via ssh on putty with above ip
20.	Update with “sudo apt update”
21.	Install nano “sudo apt-get install nano”
22.	sudo nano /usr/share/glib-2.0/schemas/org.gnome.Vino.gschema.xml
and add
<key name='enabled' type='b'>
<summary>Enable remote access to the desktop</summary>
<description>
If true, allows remote access to the desktop via the RFB
protocol. Users on remote machines may then connect to the
desktop using a VNC viewer.
</description>
<default>true</default>
</key>
23.	sudo glib-compile-schemas /usr/share/glib-2.0/schemas
24.	gsettings set org.gnome.Vino require-encryption false
25.	gsettings set org.gnome.Vino prompt-enabled false
26.	run “nmcli connection show”
27.	replace UUID and run
dconf write /org/gnome/settings-daemon/plugins/sharing/vino-server/enabled-connections "['d0e2956e-0c1b-3299-825f-7633b3b81066']"
28.	modify “sudo nano /etc/gdm3/custom.conf”
  AutomaticLoginEnable = true
  AutomaticLogin = nano
29.	reboot and run
“export DISPLAY=:0 && /usr/lib/wicomai/vino-server”
30.	open vnc viewer in 192.168.43.166:5900
31.	open startup application and add
/usr/lib/vino/vino-server
32.	reboot
33.	to change resolution add “sudo /etc/X11/xorg.conf”
Section "Monitor"
   Identifier "DSI-0"
   Option    "Ignore"
EndSection

Section "Screen"
   Identifier    "Default Screen"
   Monitor        "Configured Monitor"
   Device        "Default Device"
   SubSection "Display"
       Depth    24
       Virtual 1280 800
   EndSubSection
EndSection
34.	shutdown “sudo shutdown -h now”

Reference
•	wifi
https://desertbot.io/blog/jetson-nano-usb-headless-wifi-setup-edimax-ew-7811un
https://core.docs.ubuntu.com/en/stacks/network/network-manager/docs/configure-wifi-connections
•	vnc setup
https://github.com/Aravindseenu/Nvidia-jetson-VNC-remote-access
https://itectec.com/ubuntu/ubuntu-start-vino-vnc-server-from-ssh-client/
https://www.programmersought.com/article/68834551211/
https://www.programmersought.com/article/59874290677/
https://www.programmersought.com/article/29584651823/
•	full setup
https://www.hackster.io/news/getting-started-with-the-nvidia-jetson-nano-developer-kit-43aa7c298797
https://raspberry-valley.azurewebsites.net/NVIDIA-Jetson-Nano/
•	xrdp fix
https://forums.developer.nvidia.com/t/issue-with-xrdp/110654/22
https://c-nergy.be/blog/?p=12073
•	auto login
https://vitux.com/how-to-enable-disable-automatic-login-in-ubuntu-18-04-lts/
•	resolution fix
https://forums.developer.nvidia.com/t/jetson-tx1-desktop-sharing-resolution-problem-without-real-monitor/48041/11
•	
