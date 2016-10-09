# Script for installing StarUML on Fedora

This script was tested on Fedora 22 (read below for further instructions), 23 and 24. It downloads the version 2.70 of StarUML from its webpage. In case they update their version, please indicate it to me to test a new installation script (or maybe only change its version, hopefully).

For Fedora 22, it reached EOL, so I commented the specific line that gives libgcrypt, which is neccessary to make it work. So, you are free to uncomment them in case you need it. 

NOTE: Only use the uninstall script if you used the installation script here (or if the instructions you've used for installation are similar to the installation script). I can't assure it will work fully if not done that way. Finally, I've adapted the script to download the 32bit version, but I haven't tested it (the procedure looks the same for both, though).

Thanks to Vijaya Simha Reddy Aedavelli, because of the libudev linking detail. The instructions where this script was based on are located at https://staruml.uservoice.com/forums/245359-feature-request/suggestions/7102764-rmp-packages-for-fedora. 

Made by WolfangAukang (2016)
