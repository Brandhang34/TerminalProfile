# Sushamae Terminal Profile

<!-- ![Terminal NeoFetch](README_IMGs/TerminalProfile.png) -->
<p align="center">
  <img src="README_IMGs/TerminalProfile.png" />
</p>

This is the current profile I use for my UNIX terminals. I have only used this on the default Ubuntu terminal.

### If you dont want to read through, here is an all in one command

```bash
sudo apt-get install git -y && git clone https://github.com/Brandhang34/TerminalProfile.git && cd TerminalProfile && ./install_extras.sh && ./install_terminal_profile.sh
```

## Prerequisites

Before using the scripts, I typically like to update, upgrade and install the necessary software.

```bash
# Update your software repositories.
sudo apt-get update
sudo apt-get upgrade -y

# Install Git.
sudo apt-get install -y git

# Clone Repository
git clone https://github.com/Brandhang34/TerminalProfile.git && cd TerminalProfile
```

## Installation

Install NeoVim, [logo-ls](https://github.com/Yash-Handa/logo-ls) latest, [Nerd Font](https://www.nerdfonts.com/) (HackFont), and [ZSH](https://github.com/ohmyzsh/ohmyzsh/wiki/Installing-ZSH):

```bash
./install_extras.sh
```

Install Terminal Profile

```bash
./install_terminal_profile.sh
```

Note: Re-login after running the scripts so P10k can be configured and installation takes affect.

## 💤 LazyVim

I use [LazyVim](https://github.com/LazyVim/LazyVim) as my NeoVim configuration ([One Dark Pro Themed](https://github.com/olimorris/onedarkpro.nvim)).

<!-- ![LazyVimDefaultPage](README_IMGs/LazyVimDefaultPage.png) -->
<!-- ![LazyVimSample](README_IMGs/LazyVimSample.png) -->

<p align="center">
  <img src="README_IMGs/LazyVimDefaultPage.png" />
  <img src="README_IMGs/LazyVimSample.png" />
</p>

If you want to don't use my configurations, you can skip this.

#### NOTE:

Backup your current NeoVim files if you want to keep your configurations.

```bash
# required
mv ~/.config/nvim ~/.config/nvim.bak

# optional but recommended
mv ~/.local/share/nvim ~/.local/share/nvim.bak
mv ~/.local/state/nvim ~/.local/state/nvim.bak
mv ~/.cache/nvim ~/.cache/nvim.bak
```

Copy files to the nvim directory.

```bash
# Copy NeoVim Configurations
mkdir ~/.config/nvim
cp -r extras/nvim/* ~/.config/nvim
```

## Source/References

Links to some of the resources I used:

[Oh My Zsh!](https://medium.com/wearetheledger/oh-my-zsh-made-for-cli-lovers-installation-guide-3131ca5491fb) | [NeoVim V0.9.0](https://github.com/neovim/neovim/releases/tag/v0.9.0) | [LazyVim Documentation](https://lazyvim.github.io/installation) | [logo-ls](https://github.com/Yash-Handa/logo-ls) | [One Dark Pro](https://github.com/olimorris/onedarkpro.nvim) | [Nerd Font](https://www.nerdfonts.com/)
