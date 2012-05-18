#!/bin/bash

# Usage: ./deploy.sh user@host [attributeFile]

host=$1

CHEF_REPO_DIR="chefrepo"

# The host key might change when we instantiate a new VM, so
# we remove (-R) the old host key from known_hosts
ssh-keygen -R "${host#*@}" 2> /dev/null

deployChefRepo="
rm -rf ~/$CHEF_REPO_DIR &&
mkdir ~/$CHEF_REPO_DIR &&
cd ~/$CHEF_REPO_DIR &&
tar xj"

#copy the local chef repo to the remote host
tar cj . | ssh -o 'StrictHostKeyChecking no' $host "$deployChefRepo"

runChefSolo="cd ~/$CHEF_REPO_DIR && sudo ./run.sh"
# -t is needed to allocate a terminal an be able to use sudo
# run chef solo on the remote host
ssh -t -o 'StrictHostKeyChecking no' $host "$runChefSolo"
