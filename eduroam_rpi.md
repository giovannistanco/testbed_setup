sudo rfkill unblock wifi; sudo rfkill unblock all

rerun sudo rfkill list to confirm that the card has been unblocked.

reboot

rerun sudo rfkill list again to confirm unblocking as been retained.

rerun sudo lshw -class network - you should now see that the kernel has recognised (or not) the wireless card.

https://inrg.soe.ucsc.edu/howto-connect-raspberry-to-eduroam/
sudo su
sudo ip link set wlan0 down
sudo ip link set eth0 down
killall wpa_supplicant

nano /etc/network/interfaces

source /etc/network/interfaces.d/*
allow-hotplug wlan0

iface wlan0 inet dhcp
        wpa-conf /etc/wpa_supplicant/wpa_supplicant.conf
        
nano /etc/wpa_supplicant/wpa_supplicant.conf

network={
        ssid="eduroam"
        eap=PEAP
        key_mgmt=WPA-EAP
        phase2="auth=MSCHAPV2"
        identity="giovanni.stanco@unina.it"
        password="capriolo72"
}


Authentication Succeeded” somewhere in the output.
wpa_supplicant -i wlan0 -c /etc/wpa_supplicant/wpa_supplicant.conf****

sudo ip link set wlan0 up
sudo ip link set wlan0 up
