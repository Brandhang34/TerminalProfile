#!/bin/bash

# Fail on any command.
set -eux pipefail

sudo apt-get install curl

curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
chmod u+x nvim.appimage

./nvim.appimage --appimage-extract

#Exposing nvim globally
sudo mv squashfs-root /
sudo ln -s /squashfs-root/AppRun /usr/bin/nvim

#Install Logo-ls
sudo cp extras/logo-ls /usr/local/bin

# Add fonts
font_dir="$HOME/.local/share/fonts"
sudo mkdir -p $font_dir

# Copy all fonts to user fonts directory
echo "Copying fonts..."
sudo cp -r extras/Terminal_Profile/fonts/hackfonts/* $font_dir

# Reset font cache on Linux
if which fc-cache >/dev/null 2>&1; then
	echo "Resetting font cache, this may take a moment..."
	fc-cache -f "$font_dir"
fi

echo "Hack fonts installed to $font_dir"

# Install ZSH
sudo apt install -y git-core zsh curl
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
