#!/bin/bash

GREEN='\033[1;32m'
NC='\033[0m'

HERE=`pwd`

printf "${GREEN}Installing Retroarch dependencies...${NC}\n"
sudo apt-get -y install git build-essential
sudo apt-get -y build-dep retroarch

# create a temporary folder for this
cd ${HOME}
mkdir tmp
cd tmp

printf "${GREEN}Downloading Retroarch...${NC}\n"
git clone https://github.com/libretro/RetroArch.git retroarch

printf "${GREEN}Installing Retroarch...${NC}\n"
cd retroarch
./configure --disable-vulkan --disable-ffmpeg --enable-xmb --disable-materialui --disable-flac --disable-parport --disable-vulkan_display --disable-videocore --disable-videoprocessor --disable-v4l2 --enable-x11 --disable-wayland --disable-vg --disable-jack --disable-discord --disable-langextra --enable-mali_fbdev --enable-opengles --disable-opengl_core --disable-opengl1
make && sudo make install

printf "${GREEN}Installing video filters...${NC}\n"
cd gfx/video_filters
make
mkdir -p ${HOME}/.config/retroarch/filters/video
cp *.filt *.so ${HOME}/.config/retroarch/filters/video

printf "${GREEN}Updating retroarch.cfg...${NC}\n"
cd ${HOME}/.config/retroarch
cp retroarch.cfg retroarch.cfg.before-setup
curl -o retroarch.cfg https://raw.githubusercontent.com/hpcodecraft/gameshell-setup/master/retroarch/retroarch.cfg

printf "${GREEN}Cleaning up...${NC}\n"
cd ${HOME}
rm -rf tmp

cd ${HERE}

printf "\n${GREEN}Done! Retroarch is ready to use!${NC}\n\n"
