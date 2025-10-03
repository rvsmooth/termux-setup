#!/bin/bash
TERM_DIR="${HOME}/.termux"
# update packages
pkg update && pkg upgrade -y

# install dependencies
pkg install -y wget curl

# get font package
wget -O $TERM_DIR/font.ttf https://github.com/rvsmooth/termux-setup/blob/master/fonts/JetBrainsMonoNerdFontMono-Medium.ttf

# reload termux
am broadcast --user 0 -a com.termux.app.reload_style com.termux
