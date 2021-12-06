We try to setup a virtual environment on the Raspberry Pi for linking the Task Offloading software.\
We download Contiki NG.
```
mkdir ~/wsn
cd ~/wsn
git clone -b petras https://github.com/MBradbury/contiki-ng.git
cd contiki-ng
git submodule update --init
```
Edit `~/.bashrc` to add the path to Contiki-NG.
```
export CONTIKING_OSCORE_DIR="~/wsn/contiki-ng"
export COOJA_DIR="$CONTIKING_OSCORE_DIR/tools/cooja"
```
Clone the `iot-trust-task-alloc` public repository.
```
cd ~/wsn
git clone https://github.com/MBradbury/iot-trust-task-alloc.git
cd iot-trust-task-alloc && git submodule update --init
```
Procedure for Resource Constrained Nodes (Monitors)
```
yes | sudo apt-get install git python3-pip python3-dev pipenv python3-serial
python3 -m pip install pyserial
cd  ~
git clone https://gitlab.com/cs407-idiots/pi-client.git
cd pi-client
pipenv install
```
We get the error `Python 3.7 not found`. So we run `pipenv install --python /usr/bin`. The warning we have is `Your Pipfile requires python_version 3.7, but you are using 3.9.2.` It creates a virtualenv for this project using `/usr/bin/python3 (3.9.2)`.\
To activate this project's virtualenv, we run `pipenv shell`. The virtual environment is created. \
\
The command to run is the following. Setup does the compiling. 
```
./tools/setup.py -h
python - m tools.setup 
```
We need to install the needed packages.
```
python3 -m pip install fabric
python3 -m pip install patchwork
python3 -m pip install cbor2
python3 -m pip install numpy
yes | sudo apt-get install libatlas-base-dev

```






