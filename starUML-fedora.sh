#!/bin/bash

# This is a script for installing StarUML on Fedora
# Made by Pedro R. de Oliveira (WolfangAukang)

if [[ ! $(whoami) = "root" ]]; then
    echo "Please, execute this as root. It is required to do certain operations"
    exit 1
fi

if [[ $(uname -m) = "i386" ]] || [[ $(uname -m) = "i486" ]] || [[ $(uname -m) = "i586" ]] || [[ $(uname -m) = "i686" ]]; then
    architecture=32
else
    architecture=64
fi

version=2.7.0

echo "Downloading package..."
if [ ! -f ./StarUML-v$version-$architecture-bit.deb ]
then
	wget http://staruml.io/download/release/v2.7.0/StarUML-v$version-$architecture-bit.deb
fi

echo "Extracting files..."
ar vx StarUML-v$version-$architecture-bit.deb
tar -xf data.tar.xz

echo "Installing and linking additonal dependencies..."
dnf -y install systemd-libs binutils
wget https://copr.fedorainfracloud.org/coprs/red/libgcrypt.so.11/repo/fedora-22/red-libgcrypt.so.11-fedora-22.repo
mv red-libgcrypt.so.11-fedora-22.repo /etc/yum.repos.d/red-libgcrypt.repo
dnf -y install compat-libgcrypt
if [ ! -f /usr/lib64/libudev.so.0 ]
then
        ln -s /usr/lib64/libudev.so.1 /usr/lib64/libudev.so.0
fi

echo "Transfering files"
cp -rf opt/staruml/ /opt/
cp -rf usr/share/doc/staruml/ /usr/share/doc/
cp -rf usr/share/icons/hicolor/ /usr/share/icons/
cp staruml.desktop /usr/share/applications/

echo "Making symlink..."
if [ ! -f /usr/bin/staruml ]
then
        ln -s /opt/staruml/staruml /usr/bin/
fi

echo "Removing files..."
rm StarUML-v$version-$architecture-bit.deb
rm -rf opt/
rm -rf usr/
rm control.tar.gz
rm data.tar.xz
rm debian-binary

echo "Done! Enjoy"
