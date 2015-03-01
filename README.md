```
  ____ _           __   ____       _   _____
 / ___| |__   ___ / _| |  _ \  ___| |_|_   _|__  _ __
| |   | '_ \ / _ \ |_  | | | |/ _ \ '_ \| |/ _ \| '_ \
| |___| | | |  __/  _| | |_| |  __/ |_) | | (_) | |_) |
 \____|_| |_|\___|_|   |____/ \___|_.__/|_|\___/| .__/
                                                |_|
```


# Description

This repository is for setting up my personal Debian Desktop

# What it installs

* Updates table to Testing
* Installs the following
  * Virtualbox
  * Packer
  * Golang
  * chruby & ruby-install
  * Firefox
  * Dropbox
  * Nvidia Drivers
  * Xorg
  * st with solarized theme
  * i3-wm i3lock i3blocks
  * Rofi
  * Gmpc + MPD + MPD Scribble
  * mutt-patched + offlineimap
  * Beets music library manager

# Configuration

This mostly just installs packages and compiles a few items from source. All my 
configuration is in my dotfiles reepository.

# How to use

You can edit `config/debtop.json` to add remove items from the run list.

After which all you have to do is run bootstrap.sh. The bootstrap script installs
chef-client and chefdk. It will clone this repository and run chef solo.

If you make changes to `config/debtop.json` you'll want to fork this repository 
and edit bootstrap.sh to clone your repository.
