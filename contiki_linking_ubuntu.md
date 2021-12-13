We follow the Setup guide for the `iot-trust-task-alloc` [repository](https://github.com/MBradbury/iot-trust-task-alloc).\
We start by installing dependencies.
```
sudo apt-get install git build-essential gcc-arm-none-eabi python3 texlive-extra-utils cm-super texlive-latex-extra dvipng poppler-utils srecord rsync
python3 -m pip install pexpect
```
We download the Contiki-NG repository.
```
mkdir ~/wsn
cd ~/wsn
git clone -b petras https://github.com/MBradbury/contiki-ng.git
cd contiki-ng
git submodule update --init
```
We edit `~/.bashrc` to add the path to Contiki-NG before the interactivity check:
```
export CONTIKING_OSCORE_DIR="~/wsn/contiki-ng"
export COOJA_DIR="$CONTIKING_OSCORE_DIR/tools/cooja"
```
In order for builds to succeed we need to modify `os/net/security/tinydtls/sha2/sha2.c` by commenting out line 35 (`#include "tinydtls.h"`). #Put \\ ahead of the line.
