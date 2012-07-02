#!/bin/bash

VERSION=1.7.0
FILE_NAME=appengine-java-sdk-$VERSION.zip
URL=http://googleappengine.googlecode.com/files/appengine-java-sdk-$VERSION.zip

wget -c $URL

unzip $FILE_NAME

mv appengine-java-sdk-$VERSION ~/local/
cd ~/local
rm appengine-java-sdk
ln -s appengine-java-sdk-$VERSION appengine-java-sdk

