#!/bin/bash

GREEN='\033[1;32m'
NC='\033[0m'

printf "${GREEN}Greetings!${NC}\n\n"

MENU_CHOICE="0"

printf "${GREEN}Resize the root partition? (y/N): ${NC}"
read MENU_CHOICE

if [ "${MENU_CHOICE}" == "y" ]
then
    ./system/resize_root.sh
else
    echo "Skipped"
fi

printf "${GREEN}Updating package lists...${NC}\n"
sudo apt-get update

MENU_CHOICE="0"

printf "${GREEN}Update and configure retroarch? (y/N): ${NC}"
read MENU_CHOICE

if [ "${MENU_CHOICE}" == "y" ]
then
    ./retroarch/setup.sh
else
    echo "Skipped"
fi

MENU_CHOICE="0"
CLONED_INSTALLERS=0
HERE=`pwd`
INSTALLER_DIR="~/mods/gameshell-installers"

printf "${GREEN}Install Prince of Persia? (y/N): ${NC}"
read MENU_CHOICE

if [ "${MENU_CHOICE}" == "y" ]
then
    mkdir -p $INSTALLER_DIR
    git clone https://github.com/sbielmann/gameshell-installers.git $INSTALLER_DIR
    
    cd $INSTALLER_DIR
    chmod a+x install-*

    CLONED_INSTALLERS=1

    ./install-prince

    cd $HERE
else
    echo "Skipped"
fi

printf "${GREEN}Install Rick Dangerous? (y/N): ${NC}"
read MENU_CHOICE

if [ "${MENU_CHOICE}" == "y" ]
then
    if [ $CLONED_INSTALLERS == 0 ]
    then
        mkdir -p $INSTALLER_DIR
        git clone https://github.com/sbielmann/gameshell-installers.git $INSTALLER_DIR
    
        cd $INSTALLER_DIR
        chmod a+x install-*
    else
        cd $INSTALLER_DIR
    fi

    ./install-rick
    
    cd $HERE
else
    echo "Skipped"
fi