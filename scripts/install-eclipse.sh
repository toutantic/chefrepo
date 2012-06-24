#!/bin/bash

wget -c http://eclipse.ialto.com/technology/epp/downloads/release/indigo/SR2/eclipse-jee-indigo-SR2-linux-gtk-x86_64.tar.gz

tar -xzf eclipse-jee-indigo-SR2-linux-gtk-x86_64.tar.gz

mv eclipse ~/local/eclipse-3.7.2

cd ~/local
ln -s eclipse-3.7.2 eclipse
