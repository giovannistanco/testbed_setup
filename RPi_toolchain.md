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
We skip the installation of an ARM compiler by now...
```
# bootstrap
wget https://launchpad.net/gcc-arm-embedded/5.0/5-2015-q4-major/+download/gcc-arm-none-eabi-5_2-2015q4-20151219-linux.tar.bz2
tar xjf gcc-arm-none-eabi-5_2-2015q4-20151219-linux.tar.bz2 -C /tmp/
sudo cp -f -r /tmp/gcc-arm-none-eabi-5_2-2015q4/* /usr/local/
rm -rf /tmp/gcc-arm-none-eabi-* gcc-arm-none-eabi-*-linux.tar.bz2
export PATH=/usr/local/arm-none-eabi:$PATH
```
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
# sudo nano ~/.bashrc
#
#
## Install nRF52 SDK
wget https://developer.nordicsemi.com/nRF5_IoT_SDK/nRF5_IoT_SDK_v0.9.x/nrf5_iot_sdk_3288530.zip
sudo mkdir -p /usr/nrf52-sdk
sudo unzip nrf5_iot_sdk_3288530.zip -d /usr/nrf52-sdk
rm nrf5_iot_sdk_3288530.zip
echo "export NRF52_SDK_ROOT=/usr/nrf52-sdk" >> ${HOME}/.bashrc
#
#
#Install JLink
sudo pip install gdown
gdown --id 1OVYCL1Oly-NuQTGzSPIZGp57mssj0Id3
sudo dpkg -i JLink_Linux_V758b_arm.deb
sudo apt-get install -f

# In order to access the DK as a regular Linux user create a 99-jlink.rules file in your udev rules folder (e.g., /etc/udev/rules.d/) and add the following line to it:

# ATTRS{idProduct}=="1015", ATTRS{idVendor}=="1366", MODE="0666"
#
#
# Install Java for the Cooja network simulator
yes | sudo apt install default-jdk ant
update-alternatives --config java
echo 'export JAVA_HOME="/usr/lib/jvm/default-java"' >> ~/.profile
#
#
# Environment variables, from bootastrap.sh
echo "export JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-amd64" >> ${HOME}/.bashrc
echo "export CONTIKI_NG=${HOME}/contiki-ng" >> ${HOME}/.bashrc
echo "export COOJA=${CONTIKI_NG}/tools/cooja" >> ${HOME}/.bashrc
echo "export PATH=${HOME}:${PATH}" >> ${HOME}/.bashrc
echo "export WORKDIR=${HOME}" >> ${HOME}/.bashrc
source ${HOME}/.bashrc
#
#
# Install nrfjprog for programmin the nRF52840 DK
wget https://www.nordicsemi.com/-/media/Software-and-other-downloads/Desktop-software/nRF-command-line-tools/sw/Versions-10-x-x/10-15-0/nrf-command-line-tools-10.15.0_arm.zip
unzip nrf-command-line-tools-10.15.0_arm.zip -d nrf_commandlines
sudo dpkg -i nrf_commandlines/nrf-command-line-tools_10.15.0_armhf.deb
#
#
sudo apt install python-pip	
sudo apt install python3-pip	
sudo python3 -m pip install -U pip
sudo python3 -m pip install nrfutil
```
We have a problem during compilation of the copde, the error is probably due to the compiler.\
We try to follow this other procedure
```
wget https://armkeil.blob.core.windows.net/developer/Files/downloads/gnu-rm/9-2020q2/gcc-arm-none-eabi-9-2020-q2-update-x86_64-linux.tar.bz2
tar -xjf gcc-arm-none-eabi-9-2020-q2-update-x86_64-linux.tar.bz2
export PATH="/home/pi/gcc-arm-none-eabi-9-2020-q2-update/bin:$PATH"



```
