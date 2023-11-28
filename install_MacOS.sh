#!/bin/bash

# Fail on any command.
set -eux pipefail

# Update and install pre-reqs.
brew install git
brew install curl
brew install gcc
brew install npm
brew install ripgrep

# Install tmux
brew install tmux
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
mkdir -p ~/.config/tmux/
sudo cp extras/Terminal_Profile/configs/tmux/tmux.conf ~/.config/tmux/
/bin/bash ~/.tmux/plugins/tpm/scripts/update_plugin.sh

#Install exa
brew install exa

# Install ZSH
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# Install plug-ins.
(cd ~/.oh-my-zsh/custom/plugins && git clone https://github.com/zsh-users/zsh-syntax-highlighting)
(cd ~/.oh-my-zsh/custom/plugins && git clone https://github.com/zsh-users/zsh-autosuggestions)

# Replace the configs with the saved one.
sudo cp extras/Terminal_Profile/configs/.zshrc ~/

# Install Starship
curl -sS https://starship.rs/install.sh | sh
sudo cp extras/Terminal_Profile/configs/macos/starship.toml ~/.config

# Install NeoVim
brew install neovim

mkdir -p ~/.config/nvim
cp -r extras/nvim/* ~/.config/nvim

# Switch the shell.
chsh -s $(which zsh)
