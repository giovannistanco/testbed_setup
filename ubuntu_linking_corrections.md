We now try to solve the linking problems encountered while running the `python3 -m tools.setup basic banded --applications monitoring --target nRF52840DK` command.\
We currently have two problems.\
The terminal does not launch when we reboot the machine, so we run `sudo apt-get --reinstall install python3-minimal` on Tilda.\
The default Python3 version is not 3.7, so we run `sudo update-alternatives --set python3 /usr/bin/python3.7`.

