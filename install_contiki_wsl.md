The `wsl --install` command does not work, the option `--install` is invalid. Instead of following [the main guide](https://docs.microsoft.com/en-us/windows/wsl/install), we follow the guide for [manual installation](https://docs.microsoft.com/en-us/windows/wsl/install-manual), even if our build of Windows should support the `wsl --install` command. We enable the WSL feature using the command
```
dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
```
We then enable the Virtual Machine Platform features using the command
```
dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart
```
The machine must then be restarted. 
