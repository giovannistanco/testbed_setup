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
We follow the procedure for [Resource Rich Nodes (Edges) and Resource Constrained Nodes (Monitors)](https://github.com/MBradbury/iot-trust-task-alloc#resource-rich-nodes-edges-and-resource-constrained-nodes-monitors).
```
sudo apt-get install git python3-pip python3-dev python3-serial
sudo pip install pipenv
sudo -H pip install -U pipenv
python3 -m pip install pyserial
```
We also need to [update Python](https://dev.to/serhatteker/how-to-upgrade-to-python-3-7-on-ubuntu-18-04-18-10-5hab) for the correct use of Pipenv in the following instructions. 
```
sudo apt update -y
sudo apt install python3.7
sudo update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.6 1
sudo update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.7 2
```
Run `sudo update-alternatives --config python3` and type the number of the Python 3.7 version. We then run the following.
```
sudo rm /usr/bin/python3
sudo ln -s python3.7 /usr/bin/python3
```

```
cd  ~
git clone https://gitlab.com/cs407-idiots/pi-client.git
cd pi-client
pipenv install
```
We are having trouble using pipenv, we skip it altogether.\
We follow the [Instructions to Deploy (Manual)](https://github.com/MBradbury/iot-trust-task-alloc#instructions-to-deploy-manual).\
We install the following packages.
```
python3 -m pip install cbor2
python3 -m pip install fabric patchwork numpy
python3 -m pip install cryptography more_itertools
sudo apt-get install -y libatlas-base-dev
```
The first step is to configure and build. 
```
cd ~/wsn/iot-trust-task-alloc
python -m tools.setup basic banded --applications monitoring
```





