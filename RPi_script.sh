# Installation of the toolchain for the nrf52840 on a Raspberry Pi.
#
# At the end of the procedure, it is necessary to change one line in the /etc/udev/rules.d/99-jlink.rules file, in order to access the DK as a regular Linux user.
# ATTRS{idProduct}=="1015", ATTRS{idVendor}=="1366", MODE="0666"
#

# Installing necessary packages
yes | sudo apt update
yes | sudo apt-get update
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

# Installing the ARM toolchain
yes | sudo apt-get install gcc-arm-none-eabi 
yes | sudo apt-get install gdb-arm-none-eabi

# Installing the MSP430 compiler
yes | sudo apt-get install binutils-msp430 
yes | sudo apt-get install gcc-msp430 
yes | sudo apt-get install msp430-libc 
yes | sudo apt-get install msp430mcu 
yes | sudo apt-get install mspdebug

cd ~
# Installing the JN compiler
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

# Installing the nRF5 IOT SDK
cd ~
wget https://developer.nordicsemi.com/nRF5_IoT_SDK/nRF5_IoT_SDK_v0.9.x/nrf5_iot_sdk_3288530.zip
sudo mkdir -p /usr/nrf52-sdk
sudo unzip nrf5_iot_sdk_3288530.zip -d /usr/nrf52-sdk
rm nrf5_iot_sdk_3288530.zip
echo "export NRF52_SDK_ROOT=/usr/nrf52-sdk" >> ${HOME}/.bashrc

# Installing the SEGGER JLink software
cd ~
sudo pip install gdown
gdown --id 1S8DPG0Zq4KqDtYbIxyY51I3-JAbYvZ40
sudo dpkg -i JLink_Linux_V758c_arm.deb
sudo apt-get install -f

# Installing Java for the Cooja network simulator
yes | sudo apt install default-jdk ant
update-alternatives --config java
echo 'export JAVA_HOME="/usr/lib/jvm/default-java"' >> ~/.profile

# Enabling USB access
sudo usermod -a -G plugdev pi
sudo usermod -a -G dialout pi

# Installing nrfjprog
cd ~
wget https://www.nordicsemi.com/-/media/Software-and-other-downloads/Desktop-software/nRF-command-line-tools/sw/Versions-10-x-x/10-15-0/nrf-command-line-tools-10.15.0_arm.zip
unzip nrf-command-line-tools-10.15.0_arm.zip -d nrf_commandlines
sudo dpkg -i nrf_commandlines/nrf-command-line-tools_10.15.0_armhf.deb

# Installing nrfutil
sudo apt install python-pip	
sudo apt install python3-pip	
sudo python3 -m pip install -U pip
sudo python3 -m pip install nrfutil

# Cloning the Contiki NG library
cd ~
git clone https://github.com/contiki-ng/contiki-ng.git
cd contiki-ng 
git submodule update --init –recursive 



