#!/bin/bash
die () {
    echo -e >&2 "$@"
    exit 1
}

[ "$#" -eq 1 ] || die "Veuillez indiquer le nom d'un fichier json à utiliser to:\n./run.sh attributes"

chef_binary=/usr/bin/chef-solo
attributeFile=$1

# Are we on a vanilla system?
if ! test -f "$chef_binary"; then
	echo "OK"
	sudo ./install.sh
fi

sudo chef-solo -c config/solo.rb -j config/$attributeFile.json
