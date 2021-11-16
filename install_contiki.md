We are going to try to compile and run code for Contiki. There are three ways to set up Contiki: using Docker, using Vagrant or installing the toolchains natively on a Linux or macOS system. \
This guide follows the instructions for [setting up Contiki-NG using Vagrant](https://github.com/contiki-ng/contiki-ng/wiki/Vagrant).\
We install VirtualBox, Vagrant and Git on our Windows machine and get the Contiki-NG repository.
```
$ git clone https://github.com/contiki-ng/contiki-ng.git
```
We initialize the Vagrant image and log in via SSH.
```
$ cd contiki-ng/tools/vagrant
$ vagrant up
$ vagrant ssh
```
We run the bootstarp.sh script to install the Contiki-NG toolchain. The bootstrap.sh script installs a lot of useful tools and compilers for different platforms. In case of a Windows host, it is necessary to convert line endings of this script. From the Vagrant shell we run:
```
$ sudo apt update
$ sudo apt install dos2unix
$ dos2unix contiki-ng/tools/vagrant/bootstrap.sh
$ sudo ./contiki-ng/tools/vagrant/bootstrap.sh
```
We exit the SSH session and then restart the Vagrant image and log in to it again.
```
$ vagrant reload
$ vagrant ssh
```
We can provision the VM with a desktop environment by uncommenting thrre lines on the vagrantfile. 
```
config.vm.provider "virtualbox" do |vb|
  vb.gui = true
end
```
We then run antoher script to install VirtualBox guest additions, X and the Xfce desktop environment. If there are any problems, repeat the dos2unix operations. 
```
$ sudo ./contiki-ng/tools/vagrant/bootstrap-vbox-with-x.sh
```
When we start the image, the VirtualBox GUI is now shown. We login using username 'vagrant' and password 'vagrant' and run `sudo start` to show the Desktop. \
The next step is to follow the [Contiki-NG for nRF52 Development Kit guide](https://github.com/contiki-ng/contiki-ng/wiki/Platform-nrf52dk).
In order to compile for the nRF52 DK, we need four components. The nRF5 IOT SDK and the ARM compatible toolchain are installed by the bootstrap.sh script. The other two components are GNU make, that can be installed by running `sudo apt-get install build-essential`, and Segger JLink Software for Linux. The deb file for the JLink software can be downloaded from the [Segger website](https://www.segger.com/downloads/jlink/). From this website we download a 64-bit Deb installer. This Deb package can be downloaded using `wget` or can downloaded on our WIndows host and then moved via a shared folder. This package can be installed using the following two commands.
```
sudo dpkg -i name_of_the_package.deb
sudo apt-get install -f
```
In order to access the DK as a regular Linux user, we create a `99-jlink.rules` file in our udev rules folder (e.g., `/etc/udev/rules.d/`) and add the following line to it:
```
ATTRS{idProduct}=="1015", ATTRS{idVendor}=="1366", MODE="0666"
```



