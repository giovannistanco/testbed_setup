echo 'Lets do sudo apt update'
yes | sudo apt update
echo 'Lets do sudo apt install dos2unix'
yes | sudo apt install dos2unix
echo 'Lets do dos2unix contiki-ng/tools/vagrant/bootstrap.sh'
yes | dos2unix contiki-ng/tools/vagrant/bootstrap.sh
echo 'Lets do sudo ./contiki-ng/tools/vagrant/bootstrap.sh'
yes | sudo ./contiki-ng/tools/vagrant/bootstrap.sh
echo 'Lets do dos2unix contiki-ng/tools/vagrant/bootstrap-vbox-with-x.sh'
yes | dos2unix contiki-ng/tools/vagrant/bootstrap-vbox-with-x.sh
echo 'Lets do sudo ./contiki-ng/tools/vagrant/bootstrap-vbox-with-x.sh'
yes | sudo ./contiki-ng/tools/vagrant/bootstrap-vbox-with-x.sh
echo 'Lets do sudo apt-get install build-essential'
yes | sudo apt-get install build-essential
echo 'Lets do sudo pip install gdown'
yes | sudo pip install gdown
echo 'Lets do gdown --id 1jpilynTVTW08wyoKCijOsZhJ5RWe741O'
yes | gdown --id 1jpilynTVTW08wyoKCijOsZhJ5RWe741O
echo 'Lets do sudo dpkg -i JLink_Linux_V758a_x86_64.deb'
yes | sudo dpkg -i JLink_Linux_V758a_x86_64.deb
echo 'Lets do sudo apt-get install -f'
yes | sudo apt-get install -f
echo 'Lets do wget https://www.nordicsemi.com/'
yes | wget https://www.nordicsemi.com/-/media/Software-and-other-downloads/Desktop-software/nRF-command-line-tools/sw/Versions-10-x-x/10-15-0/nrf-command-line-tools-10.15.0_amd.zip
echo 'Lets do unzip nrf-command-line-tools'
yes | unzip nrf-command-line-tools-10.15.0_amd.zip
echo 'Lets do sudo dpkg -i nrf-command-line-tools_10.15.0_amd64.deb'
yes | sudo dpkg -i nrf-command-line-tools_10.15.0_amd64.deb
echo 'Lets do install python-pip'
yes | sudo apt install python-pip	
echo 'Lets do install python3-pip'
yes | sudo apt install python3-pip	
echo 'Lets do pip install -U pip'
yes | sudo python3 -m pip install -U pip
echo 'Lets do pip install nrfutil'
yes | sudo python3 -m pip install nrfutil
