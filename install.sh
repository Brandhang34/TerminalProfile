#!/bin/bash

# Fail on any command.
set -eux pipefail

# Update and install pre-reqs.
if [ "$(grep -Ei 'debian' /etc/*release)" ]; then
	sudo apt-get update
	sudo apt-get upgrade -y
fi

if [ "$(uname)" == "Darwin" ] || [ "$(grep -Ei 'debian' /etc/*release)" ]; then
	echo "Installing Homebrew..."
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	(
		echo
		echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"'
	) >>/home/sushamae/.zshrc
	eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
	sudo apt-get install build-essential
	# Installing gcc and neovim
	brew install gcc
	brew install neovim
	brew install tmux
	brew install node
	brew install curl
	brew install ripgrep
	brew install exa
	brew install zsh
fi

# Install tmux
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
mkdir -p ~/.config/tmux/
sudo cp extras/Terminal_Profile/configs/tmux/tmux.conf ~/.config/tmux/
/bin/bash ~/.tmux/plugins/tpm/scripts/update_plugin.sh

if [ "$(grep -Ei 'Ubuntu' /etc/*release)" ] && [ -z "$(uname -a | grep Microsoft)" ]; then
	# Checking if Ubuntu but not WSL

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
fi

# Install ZSH
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" --skip-chsh

# Install plug-ins (you can git-pull to update them later).
omz_plugins_path = "~/.oh-my-zsh/custom/plugins"
if [ -d $omz_plugins_path]; then
	git clone https://github.com/zsh-users/zsh-syntax-highlighting $omz_plugins_path
	git clone https://github.com/zsh-users/zsh-autosuggestions $omz_plugins_path
fi

# Replace the configs with the saved one.
sudo cp extras/Terminal_Profile/configs/.zshrc ~/

if [ "$(uname)" == "Darwin" ]; then
	brew install --cask kitty
	cp extras/Terminal_Profile/configs/kitty.conf ~/.config/kitty/kitty.conf
elif [ "$(grep -Ei 'Ubuntu' /etc/*release)" ] && [ -z "$(uname -a | grep Microsoft)" ]; then
	# Install Kitty Terminal and set it as the default terminal profile
	sudo apt install kitty -y
	sudo update-alternatives --set x-terminal-emulator /usr/bin/kitty
	cp extras/Terminal_Profile/configs/kitty.conf ~/.config/kitty/kitty.conf
fi

# Install Starship
curl -sS https://starship.rs/install.sh | sh
sudo cp extras/Terminal_Profile/configs/starship.toml ~/.config

# Copy NeoVim Configurations
mkdir -p ~/.config/nvim
cp -r extras/nvim/* ~/.config/nvim

# Switch the shell.
chsh -s $(which zsh)
