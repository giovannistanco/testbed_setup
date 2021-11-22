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
sudo pip install gdown  
gdown --id 1k5lKsjLBb0Y6jboYE_Yb9Jw8dfQ9ChbO
#https://drive.google.com/file/d/1k5lKsjLBb0Y6jboYE_Yb9Jw8dfQ9ChbO/view?usp=sharing
  
http://simonduq.github.io/resources/ba-elf-gcc-4.7.4-part1.tar.bz2
  http://simonduq.github.io/resources/ba-elf-gcc-4.7.4-part2.tar.bz2
  
  ```
