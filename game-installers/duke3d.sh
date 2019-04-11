#!/bin/bash

GREEN='\033[1;32m'
NC='\033[0m'
HERE=$(pwd)

INSTALL_PATH="~/games/Duke3D"
MENU_ITEM_PATH="~/apps/Menu/Duke Nukem 3D"

# install game
cd
mkdir tmp
cd tmp
sudo apt update
sudo apt install -y libflac-dev libsdl2-mixer-dev libvorbis-dev libvpx-dev
wget -r --no-parent https://svn.eduke32.com/eduke32/
cd svn.eduke32.com/eduke32/
make
mkdir ${INSTALL_PATH}
cp eduke32 ${INSTALL_PATH}
rm -rf ~/tmp

# install menu item
printf "${GREEN}Install menu item for Duke 3D? (y/N): ${NC}"
read USER_INPUT

if [ "${USER_INPUT}" == "y" ]; then
  mkdir -p ${MENU_ITEM_PATH}
  cd ${MENU_ITEM_PATH}
  echo "cd ${INSTALL_PATH}" >"Duke Nukem 3D.sh"
  echo "./eduke32" >>"Duke Nukem 3D.sh"
else
  echo "Skipped"
fi

# give instructions on how to finish installation
cd ${HERE}
printf "${GREEN}Installation finished.\nPlease copy DUKE3D.GRP from your original version to ${INSTALL_DIR} ${NC}"
