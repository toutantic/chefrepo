#!/bin/bash

chef_binary=/usr/bin/chef-solo

# Are we on a vanilla system?
if ! test -f "$chef_binary"; then
	./install.sh
fi

sudo chef-solo -c config/solo.rb -j config/attributs.json
