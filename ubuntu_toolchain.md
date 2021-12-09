We follow the guide for the [toolchain installation on Linux](https://github.com/contiki-ng/contiki-ng/wiki/Toolchain-installation-on-Linux).\
```
sudo apt-get update
sudo apt-get upgrade
sudo apt install -y build-essential doxygen git curl wireshark python-serial srecord rlwrap
sudo usermod -a -G wireshark giovanni

```
While installing Wireshark, select enable the feature that lets non-superuser capture packets (select "yes").\
