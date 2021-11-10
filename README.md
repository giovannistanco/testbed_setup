# testbed_setup

The nRF5340 DK is the development kit for the nRF5340 System-on-Chip (SoC), a dual-core Bluetooth 5.2 SoC supporting Bluetooth Low Energy, Bluetooth mesh, NFC, Thread and Zigbee. Mesh protocols like Bluetooth mesh, Thread and Zigbee can run concurrently with Bluetooth Low Energy.
The nRF5340 DK is typically powered via USB, but can be powered by a wide range of sources, within the supply range of 1.7 to 5.0 V. In addition to USB, it can be powered with external source, but also includes a CR2032 battery holder and a Li-Po battery connector, for in-field testing.

The first operation is to run the example provided by Nordic, which is an Heart Rate Monitor demo applicatoin. This proves that the kit works as expected and that the communication between the computer and the kit functions. The ZIP file containing the two HEX files for the demo application can be downloaded from the Nordic website. 
The next operation is to install nRF Connect for Desktop and nRF Connect Programmer. 
The first program to install of these two is the former. nRF Connect for Desktop is a cross-platform tool framework for assisting development on nRF devices. It contains many apps to test, monitor, measure, optimize and program applications. The nRF Connect program shows a list of apps that can be installed, in which we can find the Programmer. The Programmer can then be launched. 
nRF Connect Programmer is used to program the HEX files of the demo application. 
