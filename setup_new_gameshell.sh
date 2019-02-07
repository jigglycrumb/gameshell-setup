#!/bin/bash

GREEN='\033[1;32m'
NC='\033[0m'

printf "${GREEN}**********************************************${NC}\n"
printf "${GREEN}* Welcome!                                   *${NC}\n"
printf "${GREEN}* This installer will ask you some questions *${NC}\n"
printf "${GREEN}* Type 'y' to accept                         *${NC}\n"
printf "${GREEN}* or hit any other key to skip               *${NC}\n"
printf "${GREEN}**********************************************${NC}\n\n"

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

printf "${GREEN}Install bash aliases to ~/.bash_aliases? (y/N): ${NC}"
read MENU_CHOICE

if [ "${MENU_CHOICE}" == "y" ]
then
    # wget -O ~/.bash_aliases https://raw.githubusercontent.com/hpcodecraft/Gameshell/master/system/.bash_aliases
    wget -O ~/.bash_aliases https://raw.githubusercontent.com/hpcodecraft/Gameshell/803122eb27ce9ffa8f89bd25f5b45e92943cf15a/system/.bash_aliases
    source ~/.bash_aliases
else
    echo "Skipped"
fi

MENU_CHOICE="0"

printf "${GREEN}Install SSH screenshot tools? (y/N): ${NC}"
read MENU_CHOICE

if [ "${MENU_CHOICE}" == "y" ]
then
    mkdir ~/screenshots
    sudo apt-get -y install imagemagick
    echo "" >> ~/.bash_aliases
    echo "# alias for taking screenshots" >> ~/.bash_aliases
    echo "export DISPLAY=:0" >> ~/.bash_aliases
    echo 'alias take_screenshot="xwd -root | convert xwd:-"' >> ~/.bash_aliases
    echo "" >> ~/.bash_aliases
    source ~/.bash_aliases
    printf "\n${GREEN}Done! You can now take screenshots via SSH by running 'take_screenshot <filename>'${NC}\n"
    printf "${GREEN}e.g. 'take_screenshot ~/screenshots/screenshot.png'${NC}\n\n"
else
    echo "Skipped"
fi

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


printf "\n${GREEN}Cleaning up... ${NC}\n"
sudo apt autoremove

printf "${GREEN}**********************************************${NC}\n"
printf "${GREEN}* Finished!                                  *${NC}\n"
printf "${GREEN}* Please reload the launcher                 *${NC}\n"
printf "${GREEN}* ...and have fun with your Gameshell!       *${NC}\n"
printf "${GREEN}**********************************************${NC}\n\n"
