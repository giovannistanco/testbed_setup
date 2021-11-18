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
We then try to flash the board. We get errors.\
`make TARGET=nrf52840 hello-world.upload`
```
nrfjprog -f nrf52  --sectorerase --program build/nrf52840/dk/hello-world.hex
ERROR: No debuggers were discovered.
NOTE: For additional output, try running again with logging enabled (--log).
NOTE: Any generated log error messages will be displayed.
../../arch/cpu/nrf52840/Makefile.nrf52840:127: recipe for target 'hello-world.upload' failed
make: *** [hello-world.upload] Error 41
```
We run the command with the log enabled.
```
make TARGET=nrf52840 -- log hello-world.upload
  CC        ../../os/sys/log.c
  LD        build/nrf52840/dk/log.elf
log.o: In function `log_6addr':
/home/vagrant/contiki-ng/examples/hello-world/../../os/sys/log.c:90: multiple definition of `log_6addr'
build/nrf52840/dk/obj/log.o:/home/vagrant/contiki-ng/examples/hello-world/../../os/sys/log.c:90: first defined here
log.o: In function `log_6addr':
/home/vagrant/contiki-ng/examples/hello-world/../../os/sys/log.c:90: multiple definition of `log_6addr_compact_snprint'
build/nrf52840/dk/obj/log.o:/home/vagrant/contiki-ng/examples/hello-world/../../os/sys/log.c:90: first defined here
log.o: In function `log_6addr':
/home/vagrant/contiki-ng/examples/hello-world/../../os/sys/log.c:90: multiple definition of `log_6addr_compact'
build/nrf52840/dk/obj/log.o:/home/vagrant/contiki-ng/examples/hello-world/../../os/sys/log.c:90: first defined here
log.o: In function `log_6addr':
/home/vagrant/contiki-ng/examples/hello-world/../../os/sys/log.c:90: multiple definition of `log_lladdr'
build/nrf52840/dk/obj/log.o:/home/vagrant/contiki-ng/examples/hello-world/../../os/sys/log.c:90: first defined here
log.o: In function `log_6addr':
/home/vagrant/contiki-ng/examples/hello-world/../../os/sys/log.c:90: multiple definition of `log_lladdr_compact'
build/nrf52840/dk/obj/log.o:/home/vagrant/contiki-ng/examples/hello-world/../../os/sys/log.c:90: first defined here
log.o: In function `log_6addr':
/home/vagrant/contiki-ng/examples/hello-world/../../os/sys/log.c:90: multiple definition of `log_bytes'
build/nrf52840/dk/obj/log.o:/home/vagrant/contiki-ng/examples/hello-world/../../os/sys/log.c:90: first defined here
log.o: In function `log_6addr':
/home/vagrant/contiki-ng/examples/hello-world/../../os/sys/log.c:90: multiple definition of `log_set_level'
build/nrf52840/dk/obj/log.o:/home/vagrant/contiki-ng/examples/hello-world/../../os/sys/log.c:90: first defined here
log.o: In function `log_6addr':
/home/vagrant/contiki-ng/examples/hello-world/../../os/sys/log.c:90: multiple definition of `log_get_level'
build/nrf52840/dk/obj/log.o:/home/vagrant/contiki-ng/examples/hello-world/../../os/sys/log.c:90: first defined here
log.o: In function `log_6addr':
/home/vagrant/contiki-ng/examples/hello-world/../../os/sys/log.c:90: multiple definition of `log_level_to_str'
build/nrf52840/dk/obj/log.o:/home/vagrant/contiki-ng/examples/hello-world/../../os/sys/log.c:90: first defined here
log.o: In function `log_6addr':
/home/vagrant/contiki-ng/examples/hello-world/../../os/sys/log.c:90: multiple definition of `all_modules'
build/nrf52840/dk/obj/log.o:/home/vagrant/contiki-ng/examples/hello-world/../../os/sys/log.c:90: first defined here
log.o: In function `log_6addr':
/home/vagrant/contiki-ng/examples/hello-world/../../os/sys/log.c:90: multiple definition of `curr_log_level_main'
build/nrf52840/dk/obj/log.o:/home/vagrant/contiki-ng/examples/hello-world/../../os/sys/log.c:90: first defined here
log.o: In function `log_6addr':
/home/vagrant/contiki-ng/examples/hello-world/../../os/sys/log.c:90: multiple definition of `curr_log_level_lwm2m'
build/nrf52840/dk/obj/log.o:/home/vagrant/contiki-ng/examples/hello-world/../../os/sys/log.c:90: first defined here
log.o: In function `log_6addr':
/home/vagrant/contiki-ng/examples/hello-world/../../os/sys/log.c:90: multiple definition of `curr_log_level_snmp'
build/nrf52840/dk/obj/log.o:/home/vagrant/contiki-ng/examples/hello-world/../../os/sys/log.c:90: first defined here
log.o: In function `log_6addr':
/home/vagrant/contiki-ng/examples/hello-world/../../os/sys/log.c:90: multiple definition of `curr_log_level_coap'
build/nrf52840/dk/obj/log.o:/home/vagrant/contiki-ng/examples/hello-world/../../os/sys/log.c:90: first defined here
log.o: In function `log_6addr':
/home/vagrant/contiki-ng/examples/hello-world/../../os/sys/log.c:90: multiple definition of `curr_log_level_6top'
build/nrf52840/dk/obj/log.o:/home/vagrant/contiki-ng/examples/hello-world/../../os/sys/log.c:90: first defined here
log.o: In function `log_6addr':
/home/vagrant/contiki-ng/examples/hello-world/../../os/sys/log.c:90: multiple definition of `curr_log_level_framer'
build/nrf52840/dk/obj/log.o:/home/vagrant/contiki-ng/examples/hello-world/../../os/sys/log.c:90: first defined here
log.o: In function `log_6addr':
/home/vagrant/contiki-ng/examples/hello-world/../../os/sys/log.c:90: multiple definition of `curr_log_level_mac'
build/nrf52840/dk/obj/log.o:/home/vagrant/contiki-ng/examples/hello-world/../../os/sys/log.c:90: first defined here
log.o: In function `log_6addr':
/home/vagrant/contiki-ng/examples/hello-world/../../os/sys/log.c:90: multiple definition of `curr_log_level_nullnet'
build/nrf52840/dk/obj/log.o:/home/vagrant/contiki-ng/examples/hello-world/../../os/sys/log.c:90: first defined here
log.o: In function `log_6addr':
/home/vagrant/contiki-ng/examples/hello-world/../../os/sys/log.c:90: multiple definition of `curr_log_level_6lowpan'
build/nrf52840/dk/obj/log.o:/home/vagrant/contiki-ng/examples/hello-world/../../os/sys/log.c:90: first defined here
log.o: In function `log_6addr':
/home/vagrant/contiki-ng/examples/hello-world/../../os/sys/log.c:90: multiple definition of `curr_log_level_ipv6'
build/nrf52840/dk/obj/log.o:/home/vagrant/contiki-ng/examples/hello-world/../../os/sys/log.c:90: first defined here
log.o: In function `log_6addr':
/home/vagrant/contiki-ng/examples/hello-world/../../os/sys/log.c:90: multiple definition of `curr_log_level_tcpip'
build/nrf52840/dk/obj/log.o:/home/vagrant/contiki-ng/examples/hello-world/../../os/sys/log.c:90: first defined here
log.o: In function `log_6addr':
/home/vagrant/contiki-ng/examples/hello-world/../../os/sys/log.c:90: multiple definition of `curr_log_level_rpl'
build/nrf52840/dk/obj/log.o:/home/vagrant/contiki-ng/examples/hello-world/../../os/sys/log.c:90: first defined here
build/nrf52840/dk/obj/contiki-main.o: In function `main':
/home/vagrant/contiki-ng/examples/hello-world/../../os/contiki-main.c:129: undefined reference to `autostart_processes'
collect2: error: ld returned 1 exit status
../../arch/cpu/arm/cortex-m/Makefile.cortex-m:34: recipe for target 'build/nrf52840/dk/log.elf' failed
make: *** [build/nrf52840/dk/log.elf] Error 1
rm log.o
```
