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
In order for builds to succeed we need to modify `os/net/security/tinydtls/sha2/sha2.c` by commenting out line 35 (`#include "tinydtls.h"`). #Put \\ ahead of the line.\
We clone the `iot-trust-task-alloc` repository.
```
cd ~/wsn
git clone https://github.com/MBradbury/iot-trust-task-alloc.git
cd iot-trust-task-alloc && git submodule update --init
```
We install Wireshark.
```
cd ~
mkdir wireshark
git clone https://gitlab.com/wireshark/wireshark.git -b release-3.4
cd wireshark
yes | sudo tools/debian-setup.sh --install-optional --install-deb-deps --install-test-deps
dpkg-buildpackage -b -uc -us -jauto
cd ..
rm wireshark-{doc,dev,dbg}_*.deb
sudo dpkg -i *.deb
```
We install Pyshark, using one of these two commands.
```
python3 -m pip install --upgrade pyshark
python3 -m pip install --upgrade git+https://github.com/KimiNewt/pyshark.git#subdirectory=src
```

