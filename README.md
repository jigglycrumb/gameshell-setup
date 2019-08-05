# gameshell-setup

This repo contains an installer script to enhance a freshly installed Gameshell.

Tested on Clockwork OS 0.4 with FBTURBO drivers and a 256GB SanDisk SD card.

The installer can:

- Resize the root filesystem to fill the entire SD card
- Install some common bash aliases
- Install tools and an alias for taking screenshots via SSH
- Extend the bash prompt so it shows the current git branch
- Update Launcher and LauncherGo to the latest version
- Update retroarch to the latest version
- Install Prince of Persia and Rick Dangerous using the installers of @sbielmann

All these steps are optional and have to be confirmed, so re-running the script and choosing different options is possible

## Usage

1.  SSH into your Gameshell
2.  Run `bash <(curl -s https://raw.githubusercontent.com/hpcodecraft/gameshell-setup/master/run.sh)`

After finishing, either use a new SSH session or run `source ~/.bash_aliases` to load the new aliases.
