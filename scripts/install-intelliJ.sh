#!/bin/bash

# Ultimate 11
VERSION=11.1.2
FOLDER_NAME=idea-IU-117.418
FILE_NAME=ideaIU-11.1.2.tar.gz
URL=http://download-ln.jetbrains.com/idea/$FILE_NAME

cd ~/local
wget -c $URL
tar -xzf $FILE_NAME
mv $FOLDER_NAME ~/local/$FOLDER_NAME

rm intellij
ln -s $FOLDER_NAME intellij
rm $FILE_NAME

