# gameshell-setup

This repo contains an installer script to enhance a freshly installed Gameshell.

The installer can:
- Resize the root filesystem to fill the entire SD card
- Install some common bash aliases
- Install tools and an alias for taking screenshots via SSH
- Update retroarch to the latest version and configure it
- Install Prince of Persia and Rick Dangerous using the installers of @sbielmann

All these steps are optional and have to be confirmed, so re-running the script and choosing different options is possible

## Contents

`icons` contains different icons for consoles/games, all collected from the clockworkpi forums. None are made by me and credit goes to the respective creators - I've put them here for two reasons:

1.  Have them all in one place
2.  Being able to download them directly from the Gameshell without having to use a second system and SCP

`retroarch` contains automation for the [tutorial of @fr500](https://forum.clockworkpi.com/t/retroarch-megathread/716)

- `retroarch.cfg`, with audio, video, input & folder setup
- `setup.sh` a bash script to automate the retroarch build and setup

`system` contains

- `.bash_aliases` a couple of aliases to ease ssh use
- `resize_root.sh` a bash script that will resize the root filesystem to fill the entire SD card


## Usage

1.  SSH into your Gameshell
2.  Run `bash <(curl -s https://raw.githubusercontent.com/hpcodecraft/gameshell-setup/master/run.sh)`

After finishing, either use a new SSH session or run `source ~/.bash_aliases` to load the new aliases.
