This is the procedure to connect a brand new Raspberry Pi running Raspberry Pi Lite OS to the eduroam network.\
The Wi-Fi interface might be blcked, so it is necessary to run these commands.
```
sudo rfkill unblock wifi
sudo rfkill unblock all
sudo rfkill list #to confirm that the card has been unblocked
reboot
sudo rfkill list #to confirm unblocking 
sudo lshw -class network #you should now see that the kernel has recognised (or not) the wireless card
```
The guide we followed is [this](https://inrg.soe.ucsc.edu/howto-connect-raspberry-to-eduroam/).
```
sudo su
sudo ip link set wlan0 down
sudo ip link set eth0 down
killall wpa_supplicant
```
Edit the `/etc/network/interfaces` file. The uncommented lines must be the following.
```
source /etc/network/interfaces.d/*
allow-hotplug wlan0

iface wlan0 inet dhcp
        wpa-conf /etc/wpa_supplicant/wpa_supplicant.conf
        ```
Edit the `/etc/wpa_supplicant/wpa_supplicant.conf`, adding this configuration.
```
network={
        ssid="eduroam"
        eap=PEAP
        key_mgmt=WPA-EAP
        phase2="auth=MSCHAPV2"
        identity="xxx"
        password="xxx"
}
```
Run `wpa_supplicant -i wlan0 -c /etc/wpa_supplicant/wpa_supplicant.conf` to chech if we get `Authentication Succeeded` somewhere in the output. Terminate it with ctrl=C.
Now bring the interfaces up.
```
sudo ip link set wlan0 up
sudo ip link set wlan0 up
```
