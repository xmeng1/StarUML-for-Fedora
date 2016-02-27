#!/bin/bash

# This is a script for installing StarUML on Fedora
# Made by Pedro R. de Oliveira (WolfangAukang)

echo "Downloading package..."
wget http://staruml.io/download/release/v2.6.0/StarUML-v2.6.0-64-bit.deb

echo "Extracting files..."
ar vx StarUML-v2.6.0-64-bit
tar -xf data.tar.gz

echo "Transfering files (Please, insert your pass to become superuser)"
sudo su
cp -rf opt/staruml/ /opt/
cp -rf usr/share/doc/staruml/ /usr/share/doc/
cp -rf usr/share/icons/hicolor/ /usr/share/icons/
cp staruml.desktop /usr/share/applications/

echo "Making symlink..."
ln -s /opt/staruml/staruml /usr/bin/

echo "Removing files..."
rm StarUML-v2.6.0-64-bit.deb
rm -rf opt/
rm -rf usr/
rm control.tar.gz
rm data.tar.xz
rm debian-binary

echo "Done! Enjoy"


