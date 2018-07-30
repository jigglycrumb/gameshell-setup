#!/bin/bash

echo "Creating directories..."
mkdir -p ~/retroarch/games
mkdir -p ~/retroarch/saves
mkdir -p ~/retroarch/states
mkdir -p ~/retroarch/system

echo "Installing Retroarch dependencies..."
sudo apt-get install git build-essential
sudo apt-get build-dep retroarch

# create a temporary folder for this
cd
mkdir tmp
cd tmp

echo "Downloading Retroarch..."
git clone https://github.com/libretro/RetroArch.git retroarch

echo "Installing Retroarch..."
cd retroarch
./configure --disable-vulkan --disable-ffmpeg --enable-xmb --disable-materialui --disable-flac --disable-parport --disable-vulkan_display --disable-videocore --disable-videoprocessor --disable-v4l2 --enable-x11 --disable-wayland --disable-vg --disable-jack --enable-kms && make -j4 && sudo make install

echo "Installing video filters..."
cd gfx/video_filters
make
mkdir -p ~/.config/retroarch/filters/video
cp *.filt *.so ~/.config/retroarch/filters/video

echo "Updating retroarch.cfg..."
cd ~/.config/retroarch
cp retroarch.cfg retroarch.cfg.before-setup
curl -o retroarch.cfg https://raw.githubusercontent.com/hpcodecraft/Gameshell/master/retroarch/retroarch.cfg

echo "Cleaning up..."
cd
rm -rf tmp

echo "All done :) Retroarch is ready to use!"