#!/bin/bash

GREEN='\033[1;32m'
NC='\033[0m'

printf "${GREEN}Installing Retroarch dependencies...${NC}\n"
sudo apt-get install git build-essential
sudo apt-get build-dep retroarch

# create a temporary folder for this
cd
mkdir tmp
cd tmp

printf "${GREEN}Downloading Retroarch...${NC}\n"
git clone https://github.com/libretro/RetroArch.git retroarch

printf "${GREEN}Installing Retroarch...${NC}\n"
cd retroarch
./configure --disable-vulkan --disable-ffmpeg --enable-xmb --disable-materialui --disable-flac --disable-parport --disable-vulkan_display --disable-videocore --disable-videoprocessor --disable-v4l2 --enable-x11 --disable-wayland --disable-vg --disable-jack --enable-kms && make -j4 && sudo make install

printf "${GREEN}Installing video filters...${NC}\n"
cd gfx/video_filters
make
mkdir -p ~/.config/retroarch/filters/video
cp *.filt *.so ~/.config/retroarch/filters/video

printf "${GREEN}Updating retroarch.cfg...${NC}\n"
cd ~/.config/retroarch
cp retroarch.cfg retroarch.cfg.before-setup
curl -o retroarch.cfg https://raw.githubusercontent.com/hpcodecraft/Gameshell/master/retroarch/retroarch.cfg

printf "${GREEN}Cleaning up...${NC}\n"
cd
rm -rf tmp

printf "\n${GREEN}All done :) Retroarch is ready to use!${NC}\n\n"
