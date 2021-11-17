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
$ sudo apt update
$ sudo apt install build-essential doxygen git curl wireshark python3-serial srecord rlwrap
```
The Contiki guide suggests to install python-serial, but our WSL is not able to locate it, so we install python3-serial instead. While installing Wireshark, enable the feature that lets non-superuser capture packets (select "yes"). Then we add ourself to the Wireshark group:
```
$ sudo usermod -a -G wireshark <user>
```
We check the bitness of our Ubuntu WSL using the command `uname -m`: the output is x86_64. This will be helpful in the following installations.\
We then install an ARM compiler, which is needed for ARM-based platforms. 
```
$ wget https://developer.arm.com/-/media/Files/downloads/gnu-rm/10.3-2021.10/gcc-arm-none-eabi-10.3-2021.10-x86_64-linux.tar.bz2
$ tar -xjf gcc-arm-none-eabi-10.3-2021.10-x86_64-linux.tar.bz2
```
