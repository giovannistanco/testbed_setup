```
sudo apt update
yes | sudo apt upgrade --fix-missing

yes | sudo apt install build-essential 
yes | sudo apt install doxygen 
yes | sudo apt install git 
yes | sudo apt install curl 
yes | sudo apt install wireshark 
yes | sudo apt install python-serial 
yes | sudo apt install srecord 
yes | sudo apt install rlwrap
sudo usermod -a -G wireshark pi



# bootstrap
wget https://launchpad.net/gcc-arm-embedded/5.0/5-2015-q4-major/+download/gcc-arm-none-eabi-5_2-2015q4-20151219-linux.tar.bz2
tar xjf gcc-arm-none-eabi-5_2-2015q4-20151219-linux.tar.bz2 -C /tmp/
sudo cp -f -r /tmp/gcc-arm-none-eabi-5_2-2015q4/* /usr/local/
rm -rf /tmp/gcc-arm-none-eabi-* gcc-arm-none-eabi-*-linux.tar.bz2
export PATH=/usr/local/arm-none-eabi:$PATH

wget -nv http://simonduq.github.io/resources/mspgcc-4.7.2-compiled.tar.bz2
sudo tar xjf mspgcc*.tar.bz2 -C /tmp/ 
sudo cp -f -r /tmp/msp430/* /usr/local/
sudo rm -rf /tmp/msp430 mspgcc*.tar.bz2


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

## Install nRF52 SDK

wget https://developer.nordicsemi.com/nRF5_IoT_SDK/nRF5_IoT_SDK_v0.9.x/nrf5_iot_sdk_3288530.zip
sudo mkdir -p /usr/nrf52-sdk
sudo unzip nrf5_iot_sdk_3288530.zip -d /usr/nrf52-sdk
rm nrf5_iot_sdk_3288530.zip
echo "export NRF52_SDK_ROOT=/usr/nrf52-sdk" >> ${HOME}/.bashrc





https://drive.google.com/file/d/1w8J9tS0VEpavdTmdeNPGzpMxxAwt_DEk/view?usp=sharing
```

