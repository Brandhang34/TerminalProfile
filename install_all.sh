#!/bin/bash

# Fail on any command.
set -eux pipefail

# Update software repositories.
sudo apt-get update
sudo apt-get upgrade -y

# Install Kitty Terminal and set it as the default terminal profile
sudo apt install kitty -y
sudo update-alternatives --set x-terminal-emulator /usr/bin/kitty

# Install Curl
sudo apt-get install curl

# Install NeoVim
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

# Install plug-ins (you can git-pull to update them later).
(cd ~/.oh-my-zsh/custom/plugins && git clone https://github.com/zsh-users/zsh-syntax-highlighting)
(cd ~/.oh-my-zsh/custom/plugins && git clone https://github.com/zsh-users/zsh-autosuggestions)

# Replace the configs with the saved one.
sudo cp extras/Terminal_Profile/configs/.zshrc ~/

# Copy the p10k zsh theme
sudo mkdir $HOME/.oh-my-zsh/custom/themes/powerlevel10k/
sudo cp -r extras/Terminal_Profile/p10k/* $HOME/.oh-my-zsh/custom/themes/powerlevel10k

sudo cp extras/Terminal_Profile/.p10k.zsh ~/

# Load Kitty Terminal Profile
cp extras/Terminal_Profile/configs/kitty.conf ~/.config/kitty/kitty.conf

# dconf load /org/gnome/terminal/legacy/profiles:/:b3813e36-f781-4b57-a2f1-68502fe0fdd7/ <extras/Terminal_Profile/configs/terminal_profile.dconf

# add_list_id=b3813e36-f781-4b57-a2f1-68502fe0fdd7
# old_list=$(dconf read /org/gnome/terminal/legacy/profiles:/list | tr -d "]")

# if [ -z "$old_list" ]; then
# 	front_list="["
# else
# 	front_list="$old_list, "
# fi

# new_list="$front_list'$add_list_id']"
# dconf write /org/gnome/terminal/legacy/profiles:/list "$new_list"
# dconf write /org/gnome/terminal/legacy/profiles:/default "'$add_list_id'"

# Switch the shell.
chsh -s $(which zsh)

# Copy NeoVim Configurations
mkdir ~/.config/nvim
cp -r extras/nvim/* ~/.config/nvim