#!/bin/bash

cd ${HOME}
if [ ! -d mods ]; then
  mkdir mods
fi

cd mods
if [ ! -d gameshell-setup ]; then
  git clone https://github.com/hpcodecraft/gameshell-setup.git
fi

cd gameshell-setup
git pull
./setup_new_gameshell.sh
