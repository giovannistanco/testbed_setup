The first thing to do on a brand new Raspberry Pi is to update its software and to install some necessary packages for Contiki-NG.
```
sudo apt update
yes | sudo apt upgrade --fix-missing
yes | sudo apt install build-essential 
yes | sudo apt install doxygen 
yes | sudo apt install git 
yes | sudo apt install curl 
yes | sudo apt install wireshark 
yes | sudo apt install python-serial 
yes | sudo apt install python3-serial 
yes | sudo apt install srecord 
yes | sudo apt install rlwrap
sudo usermod -a -G wireshark pi
```
We skip the ARM toolchain installation for now since it is the one that gives much trouble.\
We install the MSP430 compiler. The guide refers to "binaries for 32-bit Ubuntu", but the recommended link does not provide useful information. 
```
wget -nv http://simonduq.github.io/resources/mspgcc-4.7.2-compiled.tar.bz2 
sudo tar xjf mspgcc*.tar.bz2 -C /tmp/ 
sudo cp -f -r /tmp/msp430/* /usr/local/ 
sudo rm -rf /tmp/msp430 mspgcc*.tar.bz2
```
We then install the JN compiler. The [guide](https://github.com/contiki-ng/contiki-ng/wiki/Platform-jn516x) mentions a compiled version for Linux 64-bit, while our system is 32-bit.
```
# Install NXP toolchain (partial, with binaries excluded. Download from nxp.com)
wget http://simonduq.github.io/resources/ba-elf-gcc-4.7.4-part1.tar.bz2
wget http://simonduq.github.io/resources/ba-elf-gcc-4.7.4-part2.tar.bz2
wget http://simonduq.github.io/resources/jn516x-sdk-4163-1416.tar.bz2
mkdir -p /tmp/jn516x-sdk /tmp/ba-elf-gcc
tar xjf jn516x-sdk-*.tar.bz2 -C /tmp/jn516x-sdk
tar xjf ba-elf-gcc-*part1.tar.bz2 -C /tmp/ba-elf-gcc
tar xjf ba-elf-gcc-*part2.tar.bz2 -C /tmp/ba-elf-gcc
sudo cp -f -r /tmp/jn516x-sdk /usr/
sudo cp -f -r /tmp/ba-elf-gcc /usr/
rm -rf jn516x*.bz2 ba-elf-gcc*.bz2 /tmp/ba-elf-gcc* /tmp/jn516x-sdk*
echo 'export PATH="/usr/ba-elf-gcc/bin:${PATH}"' >> ${HOME}/.bashrc
```
To get the NRF52dk platform to work we need to add SDK and programming tools. We follow [this guide](https://github.com/contiki-ng/contiki-ng/wiki/Platform-nrf52dk). The nRF52 DK is based on the nRF5 IOT SDK, an ARM compatible toolchain, GNU make, and Segger JLink Software for Linux. We skip the ARM compatible toolchain. GNU make is already installed, since it is included in the package `build-essential`. 
```
wget https://developer.nordicsemi.com/nRF5_IoT_SDK/nRF5_IoT_SDK_v0.9.x/nrf5_iot_sdk_3288530.zip
sudo mkdir -p /usr/nrf52-sdk
sudo unzip nrf5_iot_sdk_3288530.zip -d /usr/nrf52-sdk
rm nrf5_iot_sdk_3288530.zip
echo "export NRF52_SDK_ROOT=/usr/nrf52-sdk" >> ${HOME}/.bashrc
```
We then install JLink. On the Raspberry Pi we can download the 32-bit Linux ARM DEB installer, which is the right one for our RPi, from the[ SEGGER website](https://www.segger.com/jlink-software.html) and we install it.\
For the previous VMs, we downloaded the necessary software, uploaded on our personal Google Drive and downloaded it. The following lines are an example on how to make it work using `gdown`, which is a tool for downloading files from Google Drive. 
```
##################### Do NOT run this code on the Raspberry Pi!!!
sudo pip install gdown
gdown --id 1OVYCL1Oly-NuQTGzSPIZGp57mssj0Id3
sudo dpkg -i JLink_Linux_V758b_arm.deb
sudo apt-get install -f
```
We then change one line in the /etc/udev/rules.d/99-jlink.rules file, in order to access the DK as a regular Linux user.
```
ATTRS{idProduct}=="1015", ATTRS{idVendor}=="1366", MODE="0666"
```
The next step is installing Java for the Cooja network simulator.
```
yes | sudo apt install default-jdk ant
update-alternatives --config java
echo 'export JAVA_HOME="/usr/lib/jvm/default-java"' >> ~/.profile
```
To be able to access the USB without using sudo, the user should be part of the groups plugdev and dialout.
```
sudo usermod -a -G plugdev pi
sudo usermod -a -G dialout pi
```
We clone the Contiki NG library.
```
git clone https://github.com/contiki-ng/contiki-ng.git
cd contiki-ng
git submodule update --init --recursive
```
The `bootstarp.sh` script in the `contiki-ng/tools/vagrant/` folder of the Contiki NG repository also sets the following environment variables. We do not do this for now. 
```
# Environment variables, from bootastrap.sh
echo "export JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-amd64" >> ${HOME}/.bashrc
echo "export CONTIKI_NG=${HOME}/contiki-ng" >> ${HOME}/.bashrc
echo "export COOJA=${CONTIKI_NG}/tools/cooja" >> ${HOME}/.bashrc
echo "export PATH=${HOME}:${PATH}" >> ${HOME}/.bashrc
echo "export WORKDIR=${HOME}" >> ${HOME}/.bashrc
source ${HOME}/.bashrc
```
This concludes the installation of the toolchain for Linux.\
The next steps are described by the guide for [Contiki-NG for nRF52840](https://github.com/contiki-ng/contiki-ng/wiki/Platform-nrf52840).\
In order to compile for the nRF52840 platforms we need an ARM compatible toolchain, that we did not install, and GNU make, that should already be installed.\
The other two components we need are `nrfjprog` for programming the nRF52840 DK and `nrfutil` for programming the nRF52840 Dongle.\
nrfjprog is supplied as part of the nRF Command Line Tools and can be downloaded as follows.
```
wget https://www.nordicsemi.com/-/media/Software-and-other-downloads/Desktop-software/nRF-command-line-tools/sw/Versions-10-x-x/10-15-0/nrf-command-line-tools-10.15.0_arm.zip
unzip nrf-command-line-tools-10.15.0_arm.zip -d nrf_commandlines
sudo dpkg -i nrf_commandlines/nrf-command-line-tools_10.15.0_armhf.deb
```
nrfutil can be installed as follows.
```
sudo apt install python-pip	
sudo apt install python3-pip	
sudo python3 -m pip install -U pip
sudo python3 -m pip install nrfutil
```
Prodedure for installing the ARM compiler.\
We download the Source Tarball from the [ARM website](https://developer.arm.com/tools-and-software/open-source-software/developer-tools/gnu-toolchain/gnu-rm/downloads). The downloaded package includes a readme.txt file for full installation instructions.\
We run these commands.
```
tar xjf gcc-arm-none-eabi-10.3-2021.10-src.tar.bz2 -C /tmp/
sudo cp -f -r /tmp/gcc-arm-none-eabi-10.3-2021.10/* /usr/local/
rm -rf /tmp/gcc-arm-none-eabi-* gcc-arm-none-eabi-*-src.tar.bz2
```
The compilation is not successful, the error we get is `arm-none-eabi-gcc: not found`.\
The following procedure is taken from the `bootstrap.sh` script for Vagrant, so it is tested on VMs.
```
wget https://launchpad.net/gcc-arm-embedded/5.0/5-2015-q4-major/+download/gcc-arm-none-eabi-5_2-2015q4-20151219-linux.tar.bz2
tar xjf gcc-arm-none-eabi-5_2-2015q4-20151219-linux.tar.bz2 -C /tmp/
sudo cp -f -r /tmp/gcc-arm-none-eabi-5_2-2015q4/* /usr/local/
rm -rf /tmp/gcc-arm-none-eabi-* gcc-arm-none-eabi-*-linux.tar.bz2
```
This time `arm-none-eabi-gcc` is found. A file with this name is in /usr/local/bin/arm-none-eabi-gcc. If we run the command `file arm-none-eabi-gcc`, the output is:
```
arm-none-eabi-gcc: ELF 32-bit LSB executable, Intel 80386, version 1 (SYSV), dynamically linked, interpreter /lib/ld-linux.so.2, for GNU/Linux 2.6.8, stripped
```
We try to follow this guide for [installing Contiki OS in Raspberry Pi 3](https://techflow360.com/installing-contiki-os-in-raspberry-pi-3/) and we install all the software mentioned.
```
sudo apt-get update
sudo apt-get upgrade
yes | sudo apt-get install build-essential 
yes | sudo apt-get install binutils-msp430 
yes | sudo apt-get install gcc-msp430 
yes | sudo apt-get install msp430-libc 
yes | sudo apt-get install msp430mcu 
yes | sudo apt-get install mspdebug
yes | sudo apt-get install gcc-arm-none-eabi 
yes | sudo apt-get install gdb-arm-none-eabi
yes | sudo apt-get install openjdk-8-jdk 
yes | sudo apt-get install openjdk-8-jre 
yes | sudo apt-get install ant 
yes | sudo apt-get install libncurses5-dev
yes | sudo apt-get install lib32ncurses5
```













`###############################################`
We skip the installation of an ARM compiler by now...
```
# bootstrap
wget https://launchpad.net/gcc-arm-embedded/5.0/5-2015-q4-major/+download/gcc-arm-none-eabi-5_2-2015q4-20151219-linux.tar.bz2
tar xjf gcc-arm-none-eabi-5_2-2015q4-20151219-linux.tar.bz2 -C /tmp/
sudo cp -f -r /tmp/gcc-arm-none-eabi-5_2-2015q4/* /usr/local/
rm -rf /tmp/gcc-arm-none-eabi-* gcc-arm-none-eabi-*-linux.tar.bz2
export PATH=/usr/local/arm-none-eabi:$PATH
```
Another procedure for the ARM compiler is the following.
```
wget https://armkeil.blob.core.windows.net/developer/Files/downloads/gnu-rm/9-2020q2/gcc-arm-none-eabi-9-2020-q2-update-x86_64-linux.tar.bz2
tar -xjf gcc-arm-none-eabi-9-2020-q2-update-x86_64-linux.tar.bz2
export PATH="/home/pi/gcc-arm-none-eabi-9-2020-q2-update/bin:$PATH"
```
#
#


We try the ARMinARM repository.
```
yes | sudo apt-get install minicom 
yes | sudo apt-get install screen 
yes | sudo apt-get install autoconf 
yes | sudo apt-get install libusb-1.0-0-dev 
yes | sudo apt-get install libtool 
yes | sudo apt-get install libftdi-dev 
yes | sudo apt-get install texinfo

```
