```
sudo apt update
sudo apt install build-essential doxygen git curl wireshark python-serial srecord rlwrap
sudo usermod -a -G wireshark <user>

wget https://developer.arm.com/-/media/Files/downloads/gnu-rm/10.3-2021.10/gcc-arm-none-eabi-10.3-2021.10-x86_64-linux.tar.bz2
tar -xjf gcc-arm-none-eabi-10.3-2021.10-x86_64-linux.tar.bz2
export PATH="$/home/<username>/gcc-arm-none-eabi-10.3-2021.10/bin:$PATH"
  
wget -nv http://simonduq.github.io/resources/mspgcc-4.7.2-compiled.tar.bz2
tar xjf mspgcc-4.7.2-compiled.tar.bz2 -C /tmp/
sudo cp -f -r /tmp/msp430/* /usr/local/
rm -rf /tmp/msp430 mspgcc*.tar.bz2
 
# https://cache.nxp.com/secured/sdk/JN-SW-4163.zip does not work
# sudo pip install gdown  
# gdown --id 1k5lKsjLBb0Y6jboYE_Yb9Jw8dfQ9ChbO
#https://drive.google.com/file/d/1k5lKsjLBb0Y6jboYE_Yb9Jw8dfQ9ChbO/view?usp=sharing

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


wget https://developer.nordicsemi.com/nRF5_IoT_SDK/nRF5_IoT_SDK_v0.9.x/nrf5_iot_sdk_3288530.zip
unzip nrf5_iot_sdk_3288530.zip -d /home/stanco/nrf5_iot_sdk_unzipped
export NRF52_SDK_ROOT=/home/stanco/nrf5_iot_sdk_unzipped

sudo apt install build-essential

sudo pip install gdown
gdown --id 1jpilynTVTW08wyoKCijOsZhJ5RWe741O
sudo dpkg -i JLink_Linux_V758a_x86_64.deb
sudo apt-get install -f

sudo apt install default-jdk ant
update-alternatives --config java
echo 'export JAVA_HOME="/usr/lib/jvm/default-java"' >> ~/.profile

sudo usermod -a -G plugdev stanco
sudo usermod -a -G dialout stanco
cd contiki-ng
git submodule update --init --recursive

# Environment variables
echo "export JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-amd64" >> ${HOME}/.bashrc
echo "export CONTIKI_NG=${HOME}/contiki-ng" >> ${HOME}/.bashrc
echo "export COOJA=${CONTIKI_NG}/tools/cooja" >> ${HOME}/.bashrc
echo "export PATH=${HOME}:${PATH}" >> ${HOME}/.bashrc
echo "export WORKDIR=${HOME}" >> ${HOME}/.bashrc


# These two last commands raise errors
source ${HOME}/.bashrc
echo "#!/bin/bash\nant -Dbasedir=${COOJA} -f ${COOJA}/build.xml run" > ${HOME}/cooja && chmod +x ${HOME}/cooja







  
  ```
