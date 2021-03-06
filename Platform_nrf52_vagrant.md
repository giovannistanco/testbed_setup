We are going to try to compile and run code for Contiki. There are three ways to set up Contiki: using Docker, using Vagrant or installing the toolchains natively on a Linux or macOS system. \
This guide follows the instructions for [setting up Contiki-NG using Vagrant](https://github.com/contiki-ng/contiki-ng/wiki/Vagrant).\
We install VirtualBox, Vagrant and Git on our Windows machine and get the Contiki-NG repository.
```
git clone https://github.com/contiki-ng/contiki-ng.git
```
We initialize the Vagrant image and log in via SSH.
```
cd contiki-ng/tools/vagrant
vagrant up
vagrant ssh
```
We run the bootstarp.sh script to install the Contiki-NG toolchain. The bootstrap.sh script installs a lot of useful tools and compilers for different platforms. In case of a Windows host, it is necessary to convert line endings of this script. From the Vagrant shell we run:
```
sudo apt update
sudo apt install dos2unix
dos2unix contiki-ng/tools/vagrant/bootstrap.sh
sudo ./contiki-ng/tools/vagrant/bootstrap.sh
```
We exit the SSH session and then restart the Vagrant image and log in to it again.
```
vagrant reload
vagrant ssh
```
We can provision the VM with a desktop environment by uncommenting three lines on the vagrantfile. 
```
config.vm.provider "virtualbox" do |vb|
  vb.gui = true
end
```
We then run antoher script to install VirtualBox guest additions, X and the Xfce desktop environment. If there are any problems, repeat the dos2unix operations. 
```
dos2unix contiki-ng/tools/vagrant/bootstrap-vbox-with-x.sh
sudo ./contiki-ng/tools/vagrant/bootstrap-vbox-with-x.sh
```
When we start the image, the VirtualBox GUI is now shown. We login using username 'vagrant' and password 'vagrant' and run `sudo startx` to show the Desktop. \
The next step is to follow the [Contiki-NG for nRF52 Development Kit guide](https://github.com/contiki-ng/contiki-ng/wiki/Platform-nrf52dk).
In order to compile for the nRF52 DK, we need four components. The nRF5 IOT SDK and the ARM compatible toolchain are installed by the bootstrap.sh script. The other two components are GNU make, that can be installed by running `sudo apt-get install build-essential`, and Segger JLink Software for Linux. The deb file for the JLink software can be downloaded from the [Segger website](https://www.segger.com/downloads/jlink/). From this website we download a 64-bit Deb installer. This Deb package can be downloaded using `wget` or can downloaded on our Windows host and then moved via a shared folder. This package can be installed using the following two commands.\
We then downloaded the deb package from Google Drive.
```
sudo pip install gdown
gdown --id 1jpilynTVTW08wyoKCijOsZhJ5RWe741O
sudo dpkg -i JLink_Linux_V758a_x86_64.deb
sudo apt-get install -f
```
In order to access the DK as a regular Linux user, we create a `99-jlink.rules` file in our udev rules folder (e.g., `/etc/udev/rules.d/`) and add the following line to it:
```
ATTRS{idProduct}=="1015", ATTRS{idVendor}=="1366", MODE="0666"
```
We then run the 'Hello world' example as a native node, as a native Unix process. We run this example in native mode by typing:
```
cd examples/hello-world
make TARGET=native
./hello-world.native
```
We see the Contiki-NG boot messages and then a periodic 'Hello, world' string. \
We then run the example on a real device. Since we are on a virtual machine, we have to make sure that the USB device is visible. In order to do that, we download and install the VirtualBox Extension Pack, we enable USB support for the VM and add the device of our test. We also modify the Vagrantfile, adding the following lines.
```
config.vm.provider "virtualbox" do |vb|
  vb.customize ["modifyvm", :id, "--usb", "on"]
end
```
When all the tools are installed, we compile and flash the `examples/hello-world` application. This also allows to verify that the toolchain setup is correct. To compile the example, go to `examples/hello-world` and execute 
```
git submodule update --init
make TARGET=nrf52dk
```
If the compilation is completed without errors, flash the board:
```
make TARGET=nrf52dk hello-world.flash
```
The LED1 starts blinking, indicating the device is waiting for a connection from BLE master. 
However we get the following error. 
```
$ make TARGET=nrf52dk hello-world.flash
SDK: /usr/nrf52-sdk
SoftDevice: /usr/nrf52-sdk/components/softdevice/s1xx_iot/s1xx-iot-prototype3_nrf52_softdevice.hex
sed -e 's,#OUTPUT_FILENAME#,build/nrf52dk/hello-world.hex,' ../../arch/cpu/nrf52832/flash.jlink > hello-world.jlink
Flashing: hello-world.jlink
/usr/bin/JLinkExe -Device NRF52 -if swd -speed 1000 -CommanderScript hello-world.jlink
SEGGER J-Link Commander V7.58a (Compiled Nov 11 2021 16:54:46)
DLL version V7.58a, compiled Nov 11 2021 16:54:28


J-Link Command File read successfully.
Processing script file...

J-Link connection not established yet but required for command.
Connecting to J-Link via USB...JLinkGUIServerExe: cannot connect to X server
Updating firmware:  J-Link OB-SAM3U128-V2-NordicSemi compiled Feb  2 2021 16:47:20
Replacing firmware: J-Link OB-SAM3U128-V2-NordicSemi compiled Mar 17 2020 14:43:00
FAILED: Communication timeout. Emulator did not re-enumerate.
Cannot connect to J-Link

J-Link connection not established yet but required for command.
Connecting to J-Link via USB...FAILED: Failed to open DLL

J-Link connection not established yet but required for command.
Connecting to J-Link via USB...FAILED: Failed to open DLL


Script processing completed.

rm hello-world.jlink
```
