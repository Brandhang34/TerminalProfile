#!/bin/bash

# Fail on any command.
set -eux pipefail

# Directory Locations
CURRENT_DIR=$PWD
TEMP_DIR="/tmp"

# Update and install pre-reqs.
sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get install curl
sudo apt-get install g++ gcc
sudo apt-get install npm

# Install tmux
sudo apt-get install tmux
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
mkdir -p ~/.config/tmux/
sudo cp extras/Terminal_Profile/configs/tmux/tmux.conf ~/.config/tmux/
/bin/bash ~/.tmux/plugins/tpm/scripts/update_plugin.sh

#Install exa
sudo apt install exa

# Install Starship
curl -sS https://starship.rs/install.sh | sh
sudo cp extras/Terminal_Profile/configs/starship.toml ~/.config

# Install NeoVim
cd $TEMP_DIR
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
chmod u+x nvim.appimage

./nvim.appimage --appimage-extract

#Exposing nvim globally
sudo mv squashfs-root /
sudo ln -s /squashfs-root/AppRun /usr/bin/nvim

cd $CURRENT_DIR

# NeoVim extras:
sudo apt install ripgrep # live grep

# Copy NeoVim Configurations
mkdir -p ~/.config/nvim
cp -r extras/nvim/* ~/.config/nvim

# Install ZSH
sudo apt install -y git-core zsh curl
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# Install plug-ins (you can git-pull to update them later).
(cd ~/.oh-my-zsh/custom/plugins && git clone https://github.com/zsh-users/zsh-syntax-highlighting)
(cd ~/.oh-my-zsh/custom/plugins && git clone https://github.com/zsh-users/zsh-autosuggestions)

# Replace the configs with the saved one.
sudo cp extras/Terminal_Profile/configs/.zshrc ~/

chsh -s $(which zsh)
