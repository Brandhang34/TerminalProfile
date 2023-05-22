#!/bin/bash

# Fail on any command.
set -eux pipefail

# Install plug-ins (you can git-pull to update them later).
(cd ~/.oh-my-zsh/custom/plugins && git clone https://github.com/zsh-users/zsh-syntax-highlighting)
(cd ~/.oh-my-zsh/custom/plugins && git clone https://github.com/zsh-users/zsh-autosuggestions)

# Replace the configs with the saved one.
sudo cp extras/Terminal_Profile/configs/.zshrc ~/

# Copy the p10k zsh theme
sudo mkdir $HOME/.oh-my-zsh/custom/themes/powerlevel10k/
sudo cp -r extras/Terminal_Profile/p10k/* $HOME/.oh-my-zsh/custom/themes/powerlevel10k

sudo cp extras/Terminal_Profile/.p10k.zsh ~/


# Load Ubuntu Default Terminal Profile
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

# Load Kitty Terminal Profile
cp extras/Terminal_Profile/configs/kitty.conf ~/.config/kitty/kitty.conf

# Switch the shell.
chsh -s $(which zsh)
