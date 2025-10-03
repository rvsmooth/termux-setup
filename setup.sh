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
# Color Functions
PRED() {
  echo -e "${RED}=> $@${RESET}"
}

PGREEN() {
  echo -e "${GREEN}=> $@${RESET}"
}

PYELL() {
  echo -e "${YELLOW}=> $@${RESET}"
}

PBLUE() {
  echo -e "${BLUE}=> $@${RESET}"
}

PMAG() {
  echo -e "${MAGENTA}=> $@${RESET}"
}

PCYAN() {
  echo -e "${CYAN}=> $@${RESET}"
}

ewhite() {
  echo -e "${WHITE}=> $@${RESET}"
}

PDONE() {
  sleep 1 && PGREEN Done... && echo && sleep 1
}

PYELL Updating packages
# update packages
pkg update
yes | pkg upgrade
PDONE

PYELL Installing dependencies
# install dependencies
pkg install -y wget curl
PDONE

PYELL Removing old font if exists
[ -e "$DEF_FONT" ] && rm "$DEF_FONT"
PDONE

PYELL Installing jetbrainsmono font
wget -qO "$DEF_FONT" https://github.com/rvsmooth/termux-setup/raw/refs/heads/master/fonts/JetBrainsMonoNerdFontMono-Medium.ttf
PDONE

PYELL Installing other packages
pkg install -y android-tools starship fish || true
PDONE

PYELL Setting up shell
mkdir -p ~/.config/fish
wget -qO ~/.config/starship.toml https://raw.githubusercontent.com/rvsmooth/dotfiles/refs/heads/staging/.config/starship.toml
touch ~/.config/fish/config.fish
echo 'set -g fish_greeting
set -x TERM xterm-256color
set PATH $PATH ~/.local/bin
starship init fish | source
' | tee ~/.config/fish/config.fish
chsh -s fish
PDONE

# reload termux
am broadcast --user 0 -a com.termux.app.reload_style com.termux

# launch fish
fish
