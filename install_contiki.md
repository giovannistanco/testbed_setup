We are going to try to install Contiki on our Windows machine in order to run the basic examples. 
The first thing do to is to install Linux on our machine. The installation of Ubuntu via Microsoft Store was not successful, so we followed the [guide for manual installation](https://docs.microsoft.com/en-us/windows/wsl/install-manual).
We are going to try to compile and run code for Contiki. There are three ways to set up Contiki: using Docker, using Vagrant or installing the toolchains natively on a Linux or macOS system. 
This guide follows the instructions for [setting up Contiki-NG using Vagrant](https://github.com/contiki-ng/contiki-ng/wiki/Vagrant).
We install VirtualBox, Vagrant and Git on our Windows machine and get the Contiki-NG repository.
```
git clone https://github.com/contiki-ng/contiki-ng.git
```






