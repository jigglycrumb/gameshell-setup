#!/bin/bash

GREEN='\033[1;32m'
NC='\033[0m'

HERE=`pwd`
MENU_CHOICE="0"

printf "${GREEN}**********************************************${NC}\n"
printf "${GREEN}*                                            *${NC}\n"
printf "${GREEN}* Welcome!                                   *${NC}\n"
printf "${GREEN}*                                            *${NC}\n"
printf "${GREEN}* This installer will now update the lists   *${NC}\n"
printf "${GREEN}* of packages known to the GameShell         *${NC}\n"
printf "${GREEN}*                                            *${NC}\n"
printf "${GREEN}* Afterwards, it will ask you some questions *${NC}\n"
printf "${GREEN}*                                            *${NC}\n"
printf "${GREEN}* Type 'y' to accept                         *${NC}\n"
printf "${GREEN}* or hit any other key to skip               *${NC}\n"
printf "${GREEN}*                                            *${NC}\n"
printf "${GREEN}**********************************************${NC}\n\n"

sleep 10

printf "${GREEN}Updating package lists...${NC}\n"
sudo apt-get update

printf "${GREEN}Resize the root partition? (y/N): ${NC}"
read MENU_CHOICE

if [ "${MENU_CHOICE}" == "y" ]
then
    ./system/resize_root.sh
else
    echo "Skipped"
fi


printf "${GREEN}Install bash aliases to ~/.bash_aliases? (y/N): ${NC}"
read MENU_CHOICE

if [ "${MENU_CHOICE}" == "y" ]
then
    cp system/bash_aliases ${HOME}/.bash_aliases
else
    echo "Skipped"
fi


printf "${GREEN}Install SSH screenshot tools? (y/N): ${NC}"
read MENU_CHOICE

if [ "${MENU_CHOICE}" == "y" ]
then
    OUT_FILE="${HOME}/.bash_aliases"
    mkdir ${HOME}/screenshots
    sudo apt-get -y install imagemagick
    echo "" >> $OUT_FILE
    echo "# alias for taking screenshots" >> $OUT_FILE
    echo "export DISPLAY=:0" >> $OUT_FILE
    echo 'alias take_screenshot="xwd -root | convert xwd:-"' >> $OUT_FILE
    echo "" >> $OUT_FILE
    printf "\n${GREEN}Done! You can now take screenshots via SSH by running 'take_screenshot <filename>'${NC}\n"
    printf "${GREEN}e.g. 'take_screenshot ~/screenshots/screenshot.png'${NC}\n\n"
else
    echo "Skipped"
fi


printf "${GREEN}Show Git branch in shell prompt? (y/N): ${NC}"
read MENU_CHOICE

if [ "${MENU_CHOICE}" == "y" ]
then
    cp system/gitprompt ${HOME}/.gitprompt
    OUT_FILE="${HOME}/.bashrc"
    echo "" >> $OUT_FILE
    echo "source ${HOME}/.gitprompt" >> $OUT_FILE
    echo "" >> $OUT_FILE
    printf "\n${GREEN}Done! The current git branch will now be displayed in the prompt'${NC}\n\n"
else
    echo "Skipped"
fi

printf "${GREEN}Update and configure retroarch? (y/N): ${NC}"
read MENU_CHOICE

if [ "${MENU_CHOICE}" == "y" ]
then
    ./retroarch/setup_retroarch.sh
else
    echo "Skipped"
fi

CLONED_INSTALLERS=0
INSTALLER_DIR="${HOME}/mods/gameshell-installers"

printf "${GREEN}Install Prince of Persia? (y/N): ${NC}"
read MENU_CHOICE

if [ "${MENU_CHOICE}" == "y" ]
then
    mkdir -p ${INSTALLER_DIR}
    git clone https://github.com/sbielmann/gameshell-installers.git ${INSTALLER_DIR}
    
    cd ${INSTALLER_DIR}
    chmod a+x install-*

    CLONED_INSTALLERS=1

    ./install-prince
else
    echo "Skipped"
fi

printf "${GREEN}Install Rick Dangerous? (y/N): ${NC}"
read MENU_CHOICE

if [ "${MENU_CHOICE}" == "y" ]
then
    if [ $CLONED_INSTALLERS == 0 ]
    then
        mkdir -p ${INSTALLER_DIR}
        git clone https://github.com/sbielmann/gameshell-installers.git ${INSTALLER_DIR}
    
        cd ${INSTALLER_DIR}
        chmod a+x install-*
    else
        cd ${INSTALLER_DIR}
    fi

    ./install-rick
else
    echo "Skipped"
fi


printf "\n${GREEN}Cleaning up... ${NC}\n"
sudo apt -y autoremove

cd ${HERE}

printf "\n${GREEN}**********************************************${NC}\n"
printf "${GREEN}* Finished!                                  *${NC}\n"
printf "${GREEN}*                                            *${NC}\n"
printf "${GREEN}* Please reload the launcher                 *${NC}\n"
printf "${GREEN}* ...and have fun with your Gameshell!       *${NC}\n"
printf "${GREEN}**********************************************${NC}\n\n"
