#!/usr/bin/env sh
#from https://gist.github.com/1615295#file_install_virtualbox_latest_ubuntu.sh

VBOX_LATEST_VERSION=$(curl http://download.virtualbox.org/virtualbox/LATEST.TXT)

#sudo sh -c '. /etc/lsb-release && echo "deb http://download.virtualbox.org/virtualbox/debian ${DISTRIB_CODENAME} contrib" > /etc/apt/sources.list.d/virtualbox.list'
#wget -q http://download.virtualbox.org/virtualbox/debian/oracle_vbox.asc -O- | sudo apt-key add -
#sudo apt-get update ; sudo apt-get install dkms virtualbox-${VBOX_LATEST_VERSION}

wget -c http://download.virtualbox.org/virtualbox/${VBOX_LATEST_VERSION}/virtualbox-4.1_4.1.18-78361~Ubuntu~precise_amd64.deb

sudo dpkg -i virtualbox-4.1_4.1.18-78361~Ubuntu~precise_amd64.deb

wget -c http://download.virtualbox.org/virtualbox/${VBOX_LATEST_VERSION}/Oracle_VM_VirtualBox_Extension_Pack-${VBOX_LATEST_VERSION}.vbox-extpack -O /tmp/Oracle_VM_VirtualBox_Extension_Pack-${VBOX_LATEST_VERSION}.vbox-extpack
VBoxManage extpack uninstall "Oracle VM VirtualBox Extension Pack"
VBoxManage extpack cleanup
VBoxManage extpack install /tmp/Oracle_VM_VirtualBox_Extension_Pack-${VBOX_LATEST_VERSION}.vbox-extpack

sudo usermod -a -G vboxusers apelletier
