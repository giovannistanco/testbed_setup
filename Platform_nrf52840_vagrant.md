We follow the guide for using Contiki-NG for Nordic nRF52840 SoC.\
In order to compile for the nRF52840 platforms we need several components. The first one is an ARM compatible toolchain. arm-gcc is the toolchain used to build Contiki-NG, an it is pre-installed on the Vagrant image. Another component is GNU make, that we already installed before.\
Another component is nrfjprog for programmin the nRF52840 DK, which is supplied as part of the nRF Command Line Tools. The SEGGER software must be previously installed in its default location, `/opt/SEGGER/JLink`. We download the nRF Command Line Tools and run the installer. 
```
wget https://www.nordicsemi.com/-/media/Software-and-other-downloads/Desktop-software/nRF-command-line-tools/sw/Versions-10-x-x/10-15-0/nrf-command-line-tools-10.15.0_amd.zip
sudo dpkg -i nrf-command-line-tools_10.15.0_amd64.deb
```
After installation they are installed in `/opt/`\
Another needed component is nrfutil for programming the nRF52840 Dongle. It is also needed to upgrade `pip` before install nrfutil.
```
python3 -m pip install -U pip
sudo python3 -m pip install nrfutil
```
One the tools are installed, it is recommended to start by compiling and flashing the `examples/hello-world` application. This also verifies if the toolchain setup is correct. To compile the example, go to `examples/hello-world` and execute:
```
make TARGET=nrf52840
```
The compilation is completed without errors.\
We then try to flash the board. 
