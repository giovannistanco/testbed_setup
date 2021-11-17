The `wsl --install` command does not work, the option `--install` is invalid. Instead of following [the main guide](https://docs.microsoft.com/en-us/windows/wsl/install), we follow the guide for [manual installation](https://docs.microsoft.com/en-us/windows/wsl/install-manual), even if our build of Windows should support the `wsl --install` command. We enable the WSL feature using the command
```
dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
```
We then enable the Virtual Machine Platform features using the command
```
dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart
```
The machine must then be restarted to complete the WSL install and update to WSL 2. We download the WSL2 Linux kernel update package for x64 machines and run it. The next step is to set WSL 2 as default version when installing new Linux distributions. We do that using the command 
```
wsl --set-default-version 2
```
We then install our favourite Linux distribution from the Microsoft store. We choose [Ubuntu](https://ubuntu.com/wsl), download it and set username and password. \
The next step is to follow the guide for the [toolchain installation on Linux](https://github.com/contiki-ng/contiki-ng/wiki/Toolchain-installation-on-Linux). The first operation is installing some necessary packages.
```
sudo apt update
sudo apt install build-essential doxygen git curl wireshark python3-serial srecord rlwrap
```
The Contiki guide suggests to install python-serial, but our WSL is not able to locate it, so we install python3-serial instead. While installing Wireshark, enable the feature that lets non-superuser capture packets (select "yes"). Then we add ourself to the Wireshark group:
```
sudo usermod -a -G wireshark <user>
```
We check the bitness of our Ubuntu WSL using the command `uname -m`: the output is x86_64. This will be helpful in the following installations.\
We then install an ARM compiler, which is needed for ARM-based platforms. 
```
wget https://developer.arm.com/-/media/Files/downloads/gnu-rm/10.3-2021.10/gcc-arm-none-eabi-10.3-2021.10-x86_64-linux.tar.bz2
tar -xjf gcc-arm-none-eabi-10.3-2021.10-x86_64-linux.tar.bz2
```
We add the bin directory to our path using the command
```
export PATH="$/home/<username>/gcc-arm-none-eabi-10.3-2021.10/bin:$PATH"
```
The next step is the installation of the MSP430 compiler. 
```
wget -nv http://simonduq.github.io/resources/mspgcc-4.7.2-compiled.tar.bz2 
tar xjf mspgcc*.tar.bz2 -C /tmp/
sudo cp -f -r /tmp/msp430/* /usr/local/
rm -rf /tmp/msp430 mspgcc*.tar.bz2
```
We do not install the JN compiler since it seems it will not be of our interest.\
we focus on installing the platform for the nRF52 Development Kit.
The first step is to download the nRF5 IOT SDK, whose latest version is the 0.9.\
From the version 1 onwards, it is integrated in the nRF5 SDK. We stick to the guide and download the 0.9 version of the IOT SDK. 
```
wget https://developer.nordicsemi.com/nRF5_IoT_SDK/nRF5_IoT_SDK_v0.9.x/nrf5_iot_sdk_3288530.zip
sudo mkdir -p /usr/nrf52-sdk
sudo apt install unzip
sudo unzip nrf5_iot_sdk_3288530.zip -d /usr/nrf52-sdk
export NRF52_SDK_ROOT=/usr/nrf52-sdk
rm nrf5_iot_sdk_3288530.zip
```
We already installed the ARM toolchain, and GNU make (build-essential package). We now install Segger JLink Software for Linux. 
```
wget https://www.segger.com/downloads/jlink/JLink_Linux_x86_64.deb
sudo apt install ./JLink_Linux_x86_64.deb
sudo dpkg -i JLink_Linux_x86_64.deb
sudo apt-get install -f

wget https://www.segger.com/downloads/jlink/JLink_Linux_V759a_x86_64.deb
```
