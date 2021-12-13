We follow the guide for the [toolchain installation on Linux](https://github.com/contiki-ng/contiki-ng/wiki/Toolchain-installation-on-Linux).
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
echo 'export PATH="$/home/giovanni/gcc-arm-none-eabi-10.3-2021.10/bin:${PATH}"' >> ${HOME}/.bashrc

```
Another option is to install it using the command `sudo apt-get install gcc-arm-none-eabi`.\
Install MSP430 compiler.
```
wget -nv http://simonduq.github.io/resources/mspgcc-4.7.2-compiled.tar.bz2
tar xjf mspgcc*.tar.bz2 -C /tmp/ 
sudo cp -f -r /tmp/msp430/* /usr/local/
rm -rf /tmp/msp430 mspgcc*.tar.bz2
```
We install the JN compiler.
```
wget http://simonduq.github.io/resources/ba-elf-gcc-4.7.4-part1.tar.bz2
wget http://simonduq.github.io/resources/ba-elf-gcc-4.7.4-part2.tar.bz2
wget http://simonduq.github.io/resources/jn516x-sdk-4163-1416.tar.bz2
sudo mkdir -p /usr/jn516x-sdk /usr/ba-elf-gcc
sudo tar xjf ba-elf-gcc-*part1.tar.bz2 -C /usr/ba-elf-gcc
sudo tar xjf ba-elf-gcc-*part2.tar.bz2 -C /usr/ba-elf-gcc
sudo tar xjf jn516x-sdk-*.tar.bz2 -C /usr/jn516x-sdk
rm ba-elf-gcc-4.7.4-part*
rm jn516x*
echo 'export PATH="/usr/ba-elf-gcc/bin:${PATH}"' >> ${HOME}/.bashrc
```
Install the [nRF SDK](https://github.com/contiki-ng/contiki-ng/wiki/Platform-nrf52dk). 
```
wget https://developer.nordicsemi.com/nRF5_IoT_SDK/nRF5_IoT_SDK_v0.9.x/nrf5_iot_sdk_3288530.zip
sudo mkdir -p /usr/nrf5_iot_sdk
sudo unzip nrf5_iot_sdk_3288530.zip -d /usr/nrf5_iot_sdk
echo 'export NRF52_SDK_ROOT=/usr/nrf5_iot_sdk' >> ${HOME}/.bashrc
```
The ARM toolchain should already be installed. GNU make should be included in the `build-essential` package. We then install the [Segger JLink Software for Linux] (https://www.segger.com/jlink-software.html). We can also directly download from the website, without using terminal commands. 

```
cd ~
wget https://www.segger.com/downloads/jlink/JLink_Linux_x86_64.deb
sudo dpkg -i JLink_Linux_x86_64.deb
```
In order to access the DK as a regular Linux user, edit the `/etc/udev/rules.d/99-jlink.rules` file and change the following line.
```
ATTRS{idProduct}=="1015", ATTRS{idVendor}=="1366", MODE="0666"
```
We install Java for the Cooja network simulator.
```
sudo apt install -y default-jdk ant
update-alternatives --config java
echo 'export JAVA_HOME="/usr/lib/jvm/default-java"' >> ~/.profile
```
We grant user access to USB, improve stability for CC2538, and reboot the system.
```
sudo usermod -a -G plugdev <user>
sudo usermod -a -G dialout <user>
```
Add the line `ATTRS{idVendor}=="0451", ATTRS{idProduct}=="16c8", ENV{ID_MM_DEVICE_IGNORE}="1"` to the `/lib/udev/rules.d/77-mm-usb-device-blacklist.rules` file.\
Then reboot the system.\
We clone the repository and initialize the submodules.
```
git clone git@github.com:contiki-ng/contiki-ng.git
cd contiki-ng
git submodule update --init --recursive
```
We test if the toolchain is correctly installed. we move into the `contiki-ng/examples/hello-world` folder and run `make TARGET=nrf52dk`.\
We also run the following commands.
```
make TARGET=nrf52dk erase
make TARGET=nrf52dk softdevice.flash
```
If the compilation is completed without errors flash the board using `make TARGET=nrf52dk hello-world.flash`.\
\
We now follow the guide for [Contiki-NG for nRF52840](https://github.com/contiki-ng/contiki-ng/wiki/Platform-nrf52840).\
Two prerequisites of this guide are an ARM compatible toolchain and GNU Make: these two componenets should already be installed.\
The other two components we need are nrfjprog for programming the nRF52840 DK and nrfutil for programming the nRF52840 Dongle.\
nrfjprog is supplied as part of the nRF Command Line Tools and can be downloaded as follows.
```
wget https://www.nordicsemi.com/-/media/Software-and-other-downloads/Desktop-software/nRF-command-line-tools/sw/Versions-10-x-x/10-15-1/nrf-command-line-tools-10.15.1_Linux-amd64.zip
unzip nrf-command-line-tools-10.15.1_Linux-amd64.zip -d nrf_commandlines
sudo dpkg -i nrf_commandlines/nrf-command-line-tools_10.15.1_amd64.deb  
# sudo dpkg -i nrf_commandlines/JLink_Linux_V758b_x86_64.deb  # This is optional, it raises a downgrading warning.
```
nrfutil can be installed as follows.
```
sudo apt install -y python-pip	
sudo apt install -y python3-pip	
sudo python3 -m pip install -U pip
sudo python3 -m pip install nrfutil
```

