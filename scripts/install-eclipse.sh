#!/bin/bash

#indigo JEE 64bits
#VERSION=3.7.2
#FILE_NAME=eclipse-jee-indigo-SR2-linux-gtk-x86_64.tar.gz
#URL=http://eclipse.ialto.com/technology/epp/downloads/release/indigo/SR2/$FILE_NAME

#juno Java 64bits
VERSION=4.2
FILE_NAME=eclipse-java-juno-linux-gtk-x86_64.tar.gz
URL=http://eclipse.ialto.com/technology/epp/downloads/release/juno/R/$FILE_NAME

wget -c $URL

tar -xzf $FILE_NAME

mv eclipse ~/local/eclipse-$VERSION

cd ~/local
rm eclipse
ln -s eclipse-$VERSION eclipse
