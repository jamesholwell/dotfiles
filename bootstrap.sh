#!/usr/bin/env bash

# move to the directory of this script
cd "$(dirname "${BASH_SOURCE}")";

git pull origin main;

function syncSettings() {
	rsync \
	    --exclude ".git/" \
		--exclude ".DS_Store" \
		--exclude "bootstrap.sh" \
		--exclude "LICENSE" \
		-avh --no-perms . ~;
}

if [ "$1" == "--force" -o "$1" == "-f" ]; then
	syncSettings;
else
	read -p "Are you sure you want to sync your dotfiles? (y/n) " -n 1;
	echo "";
	if [[ $REPLY =~ ^[Yy]$ ]]; then
		syncSettings;
	fi;
fi;

unset syncSettings;
