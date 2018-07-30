#!/bin/bash

# create directories
echo "Creating directories..."
mkdir -p ~/retroarch/games
mkdir -p ~/retroarch/saves
mkdir -p ~/retroarch/states
mkdir -p ~/retroarch/system

# install retroarch build dependencies
echo "Installing Retroarch dependencies..."
sudo apt-get install git build-essential
sudo apt-get build-dep retroarch

# create a temporary folder for this
cd
mkdir tmp
cd tmp

# download retroarch
echo "Downloading Retroarch..."
git clone https://github.com/libretro/RetroArch.git retroarch

# build it
echo "Installing Retroarch..."
cd retroarch
./configure --disable-vulkan --disable-ffmpeg --enable-xmb --disable-materialui --disable-flac --disable-parport --disable-vulkan_display --disable-videocore --disable-videoprocessor --disable-v4l2 --enable-x11 --disable-wayland --disable-vg --disable-jack --enable-kms && make -j4 && sudo make install

# build & install video filters
echo "Installing video filters..."
cd gfx/video_filters
make
mkdir -p ~/.config/retroarch/filters/video
cp *.filt *.so ~/.config/retroarch/filters/video

# download proper retroarch.cfg
echo "Updating retroarch.cfg..."
cd ~/.config/retroarch
cp retroarch.cfg retroarch.cfg.before-setup
curl -o retroarch.cfg https://raw.githubusercontent.com/hpcodecraft/Gameshell/master/retroarch/retroarch.cfg

# remove downloaded files
echo "Cleaning up..."
cd
rm -rf tmp

echo "All done :) Retroarch is ready to use!"