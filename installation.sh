#!/bin/bash

# This is a script for installing StarUML on Fedora
# Made by Pedro R. de Oliveira (WolfangAukang)

if [[ ! $(whoami) = "root" ]]; then
    echo "Please, execute this as root. It is required to do certain operations"
    exit 1
fi

if [[ $(uname -m) = "i386" ]] || [[ $(uname -m) = "i486" ]] || [[ $(uname -m) = "i586" ]] || [[ $(uname -m) = "i686" ]]; then
    architecture=32
    libVersion=i586
else
    architecture=64
    libVersion=x86_64
fi

version=2.8.0

echo "Downloading package..."
if [ ! -f ./StarUML-v$version-$architecture-bit.deb ]
then
        #Check if it has curl or wget
        if type curl > /dev/null; then
	   curl -O -L http://staruml.io/download/release/v$version/StarUML-v$version-$architecture-bit.deb
        elif type wget > /dev/null; then
	   wget http://staruml.io/download/release/v$version/StarUML-v$version-$architecture-bit.deb          
        else
           echo "You must install curl or wget to download the compiled packages."
           exit 1
        fi
else
        echo "There were errors downloading the package"
        exit 1
fi

echo "Extracting files..."
ar vx StarUML-v$version-$architecture-bit.deb
tar -xf data.tar.xz

echo "Installing and linking additonal dependencies..."
dnf -y install systemd-libs binutils 
#compat-libgcrypt seems to be not available so we will proceed to install libgcrypt from here
wget http://download.opensuse.org/repositories/home:/fstrba/openSUSE_13.2/$libVersion/libgcrypt11-1.5.4-1.1.$libVersion.rpm
rpm -Uvh libgcrypt11-1.5.4-1.1.$libVersion.rpm
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
rm -rf opt/
rm -rf usr/
rm control.tar.gz
rm data.tar.xz
rm debian-binary
rm StarUML-v$version-$architecture-bit.deb
rm libgcrypt11-1.5.4-1.1.$libVersion.rpm

echo "Done! Enjoy"
