Our reference guide is the guide for [Toolchain installation on Linux](https://github.com/contiki-ng/contiki-ng/wiki/Toolchain-installation-on-Linux). However this is specific for Ubuntu-64, while the architecture of the RPi is ARM-32. We also use a guide for [installing Contiki OS in Raspberry Pi 3](https://techflow360.com/installing-contiki-os-in-raspberry-pi-3/) as reference, since it tells us which are the correct packages for the Raspberry Pi.\
The first thing to do is to install some necessary packages for Contiki-NG. We do NOT run `apt upgrade` because it fills the disk space and at the end of our operations we might get problems because there might not be any available space. 
```
sudo apt update
sudo apt-get update
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
We install the ARM toolchain, installing the packages suggested by the RPi guide, and not using the procedure of the Contiki NG Wiki. 
```
yes | sudo apt-get install gcc-arm-none-eabi 
yes | sudo apt-get install gdb-arm-none-eabi
```
We install the MSP430 compiler.
```
yes | sudo apt-get install binutils-msp430 
yes | sudo apt-get install gcc-msp430 
yes | sudo apt-get install msp430-libc 
yes | sudo apt-get install msp430mcu 
yes | sudo apt-get install mspdebug
```
We then install the JN compiler. The [guide](https://github.com/contiki-ng/contiki-ng/wiki/Platform-jn516x) refers to a compiled version for Linux 64-bit, while our system is 32-bit. We do not have other alternatives, so we follow the 64-bit procedure. 
```
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
To get the NRF52dk platform to work we need to add SDK and programming tools. We follow [this guide](https://github.com/contiki-ng/contiki-ng/wiki/Platform-nrf52dk). The nRF52 DK is based on the nRF5 IOT SDK, an ARM compatible toolchain, GNU make, and Segger JLink Software for Linux. The ARM compatible toolchain is already installed, GNU make is included in the package `build-essential`. \
We install the nRF5 IOT SDK.
```
wget https://developer.nordicsemi.com/nRF5_IoT_SDK/nRF5_IoT_SDK_v0.9.x/nrf5_iot_sdk_3288530.zip
sudo mkdir -p /usr/nrf52-sdk
sudo unzip nrf5_iot_sdk_3288530.zip -d /usr/nrf52-sdk
rm nrf5_iot_sdk_3288530.zip
echo "export NRF52_SDK_ROOT=/usr/nrf52-sdk" >> ${HOME}/.bashrc
```
We then install JLink. On the Raspberry Pi we can download the 32-bit Linux ARM DEB installer, which is the right one for our RPi, from the [SEGGER website](https://www.segger.com/jlink-software.html) and we install it.\
For the previous VMs, we downloaded the necessary software, uploaded it on our personal Google Drive and downloaded it. The following lines are an example on how to make it work using `gdown`, which is a tool for downloading files from Google Drive. 
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
This concludes the installation of the toolchain for Linux.\
The next steps are described by the guide for [Contiki-NG for nRF52840](https://github.com/contiki-ng/contiki-ng/wiki/Platform-nrf52840).\
In order to compile for the nRF52840 platforms we need an ARM compatible toolchain, and GNU make, that are already installed.\
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
We now clone the Contiki NG library.
```
git clone https://github.com/contiki-ng/contiki-ng.git
```
If we try to compile, we get the following error. 

``` 

$ make TARGET=nrf52840 

../../arch/cpu/nrf52840/Makefile.nrf52840:4: ../../arch/cpu/nrf52840/lib/nrf52-sdk does not exist or is empty. 

../../arch/cpu/nrf52840/Makefile.nrf52840:5: Did you run 'git submodule update --init' ? 

../../arch/cpu/nrf52840/Makefile.nrf52840:6: *** "".  Stop. 

``` 
We then run an instruction that we skipped before. The commands are the following.
``` 
cd contiki-ng 
git submodule update --init –recursive 
``` 
We run the command `make TARGET=nrf52840`: it compiles!\

We then run the command for flashing the code on the board. It works! The output is in the following.
``` 

$ make TARGET=nrf52840 hello-world.upload 

nrfjprog -f nrf52  --sectorerase --program build/nrf52840/dk/hello-world.hex 
Parsing image file. 
Applying system reset. 
Verified OK. 
nrfjprog -f nrf52  --reset 
Applying system reset. 
Run. 
``` 
