We try to setup a virtual environment on the Raspberry Pi for linking the Task Offloading software.
```
sudo apt-get install git build-essential gcc-arm-none-eabi python3 texlive-extra-utils cm-super texlive-latex-extra dvipng poppler-utils srecord rsync
python3 -m pip install pexpect
```
We download Contiki NG.
```
mkdir ~/wsn
cd ~/wsn
git clone -b petras https://github.com/MBradbury/contiki-ng.git
cd contiki-ng
git submodule update --init
```
