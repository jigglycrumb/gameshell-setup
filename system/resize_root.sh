#!/bin/bash

GREEN='\033[1;32m'
NC='\033[0m'

printf "${GREEN}Installing dependencies...${NC}\n"

# Install growpart util
export DEBIAN_FRONTEND=noninteractive
sudo apt-get -y install cloud-guest-utils

printf "${GREEN}Growing partition...${NC}\n"

# Grow root partition
sudo growpart /dev/mmcblk0 2

printf "${GREEN}Resizing file system...${NC}\n"

# Resize file system
sudo resize2fs /dev/mmcblk0p2

printf "${GREEN}Cleaning up...${NC}\n"

# Uninstall growpart package again
sudo apt-get -y remove cloud-guest-utils

printf "\n${GREEN}Done! Reload UI and Check Settings->Storage 😊 ${NC}\n\n"