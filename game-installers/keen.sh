#!/bin/bash

GREEN='\033[1;32m'
NC='\033[0m'
HERE=$(pwd)

INSTALL_PATH="/home/cpi/games/CommanderGenius"
MENU_ITEM_PATH="/home/cpi/apps/Menu/CommanderGenius"

# install game

# CommanderGenius 2.3.0
cd ~
mkdir tmp
cd tmp
wget https://gitlab.com/Oet/Commander-Genius/uploads/79c009d983eaacccc8e475c80cade422/CommanderGenius.zip
unzip CommanderGenius.zip
mv CommanderGenius/ /home/cpi/games/
mv .CommanderGenius/ /home/cpi/
cd ~
rm -rf tmp

# ???
ln -s "${INSTALL_PATH}" /home/cpi/.CommanderGenius/games

# install menu item
printf "${GREEN}Install menu item for Commander Keen? (y/N): ${NC}"
read USER_INPUT

if [ "${USER_INPUT}" == "y" ]; then
  mkdir -p "${MENU_ITEM_PATH}"
  echo "${INSTALL_PATH}/CommanderGenius" >"${MENU_ITEM_PATH}/CommanderGenius.sh"
  wget https://gitlab.com/Oet/Commander-Genius/uploads/4fef7d77bce50d5d141ff6a622ad8c52/CommanderGenius.png -P "${MENU_ITEM_PATH}"
  chmod 755 "${MENU_ITEM_PATH}/CommanderGenius.sh"
else
  echo "Skipped"
fi

# give instructions on how to finish installation
cd ${HERE}
printf "${GREEN}Installation finished.\nPlease copy your original game files to ${INSTALL_PATH}${NC}\n\n"
