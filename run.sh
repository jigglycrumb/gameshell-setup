#!/bin/bash

cd
mkdir mods
cd mods
git clone https://github.com/hpcodecraft/Gameshell.git gameshell-setup
cd gameshell-setup
git checkout extended_setup_script
./setup_new_gameshell.sh