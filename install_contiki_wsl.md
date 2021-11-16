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
We then install our favourite Linux distribution from the Microsoft store. We choose [Ubuntu(https://ubuntu.com/wsl), download it and set username and password. 
