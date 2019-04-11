#!/bin/bash

GREEN='\033[1;32m'
NC='\033[0m'
HERE=$(pwd)

INSTALL_PATH="/home/cpi/games/QUAKE/Quake1/id1"
MENU_ITEM_PATH="/home/cpi/apps/Menu/Quake"

# install game
sudo apt-get update
sudo apt-get -y install quakespasm

cd ~
mkdir -p "${INSTALL_PATH}"
mkdir -p .quakespasm
cd .quakespasm && ln -s "${INSTALL_PATH}" .

# install menu item
printf "${GREEN}Install menu item for Quake? (y/N): ${NC}"
read USER_INPUT

if [ "${USER_INPUT}" == "y" ]; then
  mkdir "${MENU_ITEM_PATH}"
  echo "/usr/games/quakespasm -width 320 -height 240 -basedir /home/cpi/.quakespasm/" >"${MENU_ITEM_PATH}/Quake.sh"
  chmod 755 "${MENU_ITEM_PATH}/Quake.sh"
else
  echo "Skipped"
fi

# give instructions on how to finish installation
cd ${HERE}
printf "${GREEN}Installation finished.\nPlease copy your original pak0.pak and pak1.pak to ${INSTALL_PATH}${NC}\n\n"

# Copy the pak0.pak and pak1.pak files, from your CD, to /home/cpi/games/QUAKE/Quake1/id1
