# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"


# Plugins
plugins=(
  git
  zsh-syntax-highlighting
  zsh-autosuggestions
)

source $ZSH/oh-my-zsh.sh

eval "$(starship init zsh)"

# Exports
export TERM=xterm-256color
export DISPLAY="127.0.0.1:10.0"

# User configuration

alias ls="exa --icons --group-directories-first"

alias c=clear
alias s='source ~/.zshrc'
alias e=exit

alias a='sh ~/.ssh/gum_ssh.sh'

#creating directories alias
function take {
  mkdir -p $1
  cd $1
}


# Alias for SSH
[ "$TERM" = "xterm-kitty" ] && alias ssh="kitty +kitten ssh"
