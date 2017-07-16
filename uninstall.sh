#!/bin/bash

# Script to remove StarUML from Fedora. Please, only use this script if you installed xMind from the script starUML-fedora.sh
# Made by Pedro R. de Oliveira (WolfangAukang)

if [[ ! $(whoami) = "root" ]]; then
    echo "Please, execute this as root. It is required to remove directories"
    exit 1
fi

echo "Removing directories..."
rm -rf /opt/staruml/
rm -rf /usr/share/doc/staruml/
rm -rf /usr/share/icons/hicolor/scalable/apps/staruml.svg 
rm /usr/share/applications/staruml.desktop
rm /usr/bin/staruml

while true;
do
    read -p "Do you wish to remove external libgcrypt library? (not recommended if you are not sure) [y/N]" yn
    case $yn in
	[Yy]* ) dnf remove libgcrypt11 -y
                break;;
	* ) break;;
    esac
done

echo "Done! Thanks"
