We follow the guide for the [toolchain installation on Linux](https://github.com/contiki-ng/contiki-ng/wiki/Toolchain-installation-on-Linux).\
```
sudo apt-get update
sudo apt-get upgrade
sudo apt install -y build-essential doxygen git curl wireshark python-serial srecord rlwrap
sudo usermod -a -G wireshark giovanni

```
While installing Wireshark, select enable the feature that lets non-superuser capture packets (select "yes").\
Install an ARM compiler from [this website](https://developer.arm.com/tools-and-software/open-source-software/developer-tools/gnu-toolchain/gnu-rm/downloads).

```
wget https://developer.arm.com/-/media/Files/downloads/gnu-rm/10.3-2021.10/gcc-arm-none-eabi-10.3-2021.10-x86_64-linux.tar.bz2
tar -xjf gcc-arm-none-eabi-10.3-2021.10-x86_64-linux.tar.bz2 
export PATH="$/home/giovanni/gcc-arm-none-eabi-10.3-2021.10/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin"
```
