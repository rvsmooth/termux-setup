#!/bin/bash
# Color Codes
RESET='\033[0m'
BLACK='\033[0;30m'
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
CYAN='\033[0;36m'
WHITE='\033[0;37m'

# Variables
TERM_DIR="${HOME}/.termux"
DEF_FONT="${TERM_DIR}/font.ttf"
CONFIGS="${HOME}/.config"

# Color Functions
__pred() {
  echo -e "${RED}=> $@${RESET}"
}

__pgreen() {
  echo -e "${GREEN}=> $@${RESET}"
}

__pyellow() {
  echo -e "${YELLOW}=> $@${RESET}"
}

__pdone() {
  sleep 1 && __pgreen 'Done<=' && echo && sleep 1
}

# package array
PKGS=(
  aria2
  android-tools
  fastfetch
  fish
  neovim
  starship
  yt-dlp
)

# update packages
__pyellow Updating packages
pkg update
yes | pkg upgrade
__pdone

# install dependencies
__pyellow Installing dependencies
pkg install -y wget curl git
__pdone

__pyellow Removing old font if exists
[ -e "$DEF_FONT" ] && rm "$DEF_FONT"
__pdone

__pyellow Installing jetbrainsmono font
wget -qO "$DEF_FONT" \
  https://github.com/rvsmooth/termux-setup/raw/refs/heads/master/fonts/JetBrainsMonoNerdFontMono-Medium.ttf
__pdone

__pyellow Installing other packages
for package in "${PKGS[@]}"; do
  yes | pkg install "$package"
done
__pdone

__pyellow Setting up dotfiles
[ -d "$CONFIGS" ] && rm -rf "$CONFIGS"
git clone https://github.com/rvsmooth/termux-configs.git "$CONFIGS"
__pdone

__pyellow Installing mutagen
__pyellow needed for yt-dlp
pip install mutagen
__pdone

__pyellow Changing shell to fish
chsh -s fish
__pdone

# start fish shell
fish

# reload termux
am broadcast --user 0 -a com.termux.app.reload_style com.termux
