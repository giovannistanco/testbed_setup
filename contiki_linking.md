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
Add these line at the end of the .bashrc file and reboot the device.\
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
# ./tools/setup.py -h
python - m tools.setup 
```
These commands give different errors when trying to compile. We run the second. 
We need to install the needed packages.
```
python3 -m pip install fabric
python3 -m pip install patchwork
python3 -m pip install cbor2
python3 -m pip install numpy
yes | sudo apt-get install libatlas-base-dev
# python3 -m pip install common
```
We need to create a `common/configuration.py` file to make it work. We copy the `/common/configuration.py.example` file, without changing anything.\
Setup need two arguments: trust_model and trust_choose. We choose one of the posible trust_model and trust_choose present in `wsn/common/trust`. \
We run `python -m tools.setup basic banded`.\
If you need a more verbose output, delete the line `capture_output=True` in the `_clean_build_dirs` method of the `tools/setup.py` file, and run `python -m tools.setup basic banded --verbose-make`.\
The error is now in the `_generate_static_keys_and_build` method, in the `tools/setup.py` script. The error is that `join(self.applications)` can only join an iterable. So we use one of the possible applications present in `wsn/applications` as input argument. The command we run is
```
python -m tools.setup basic banded --verbose-make --applications monitoring
```









