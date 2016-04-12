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

echo "Done! Thanks"
