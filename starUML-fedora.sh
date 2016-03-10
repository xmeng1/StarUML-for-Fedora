#!/bin/bash

# This is a script for installing StarUML on Fedora
# Made by Pedro R. de Oliveira (WolfangAukang)
#NOTE1: Please, install binutils before executing this script. I've checked Fedora Spin KDE 22 and it doesn't have this installed as default.
#NOTE2: If you don't have libgcrypt.so.11, get the red copr by executing "sudo dnf copr enable red/libgcrypt.so.11" and later do "sudo dnf install compat-libgcrypt". I've checked Fedora Spin KDE 22 and it doesn't have it as default.

if [[ ! $(whoami) = "root" ]]; then
    echo "Please, execute this as root. It is required to do certain operations"
    exit 1
fi

if [[ $(uname -m) = "i386" ]] || [[ $(uname -m) = "i486" ]] || [[ $(uname -m) = "i586" ]] || [[ $(uname -m) = "i686" ]]; then
    architecture=32
else
    architecture=64
fi

echo "Downloading package..."
wget http://staruml.io/download/release/v2.6.0/StarUML-v2.6.0-$architecture-bit.deb

echo "Extracting files..."
ar vx StarUML-v2.6.0-$architecture-bit.deb
tar -xf data.tar.xz

echo "Installing and linking additonal dependencies..."
dnf -y install systemd-libs
ln -s /usr/lib64/libudev.so.1 /usr/lib64/libudev.so.0

echo "Transfering files"
cp -rf opt/staruml/ /opt/
cp -rf usr/share/doc/staruml/ /usr/share/doc/
cp -rf usr/share/icons/hicolor/ /usr/share/icons/
cp staruml.desktop /usr/share/applications/

echo "Making symlink..."
ln -s /opt/staruml/staruml /usr/bin/

echo "Removing files..."
rm StarUML-v2.6.0-$architecture-bit.deb
rm -rf opt/
rm -rf usr/
rm control.tar.gz
rm data.tar.xz
rm debian-binary

echo "Done! Enjoy"
