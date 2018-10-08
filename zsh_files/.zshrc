export TERM='xterm-256color'
# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
  export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="powerlevel9k/powerlevel9k"
POWERLEVEL9K_MODE='awesome-fontconfig'
#ZSH_THEME="candy"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
 ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

#Ruby
#export 

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Customize to your needs...

# Plugins
source "$HOME/dotfiles/zsh-plugins/zsh-notify/notify.plugin.zsh"
source "$HOME/dotfiles/zsh-plugins/zshmarks/zshmarks.plugin.zsh"

# Aliases
#source "$HOME/dotfiles/aliases.zsh"
source "$HOME/DotsMine/zsh_files/aliases.zsh"
# PATH
export PATH=$PATH:/$HOME/.composer/vendor/bin:.vendor/bin/:$HOME/bin:/usr/local/bin

PATH="$(ruby -e 'print Gem.user_dir')/bin:$PATH"
PATH="/root/.gem/ruby/2.3.0/bin:$PATH"

# Editor
export EDITOR=nano

export PS1="[%* - %D] %d %% "


# NPM packages
NPM_PACKAGES="${HOME}/.npm-packages"
NODE_PATH="$NPM_PACKAGES/lib/node_modules:$NODE_PATH"
PATH="$NPM_PACKAGES/bin:$PATH"
# Unset manpath so we can inherit from /etc/manpath via the `manpath`
# # command
unset MANPATH # delete if you already modified MANPATH elsewhere in your config
MANPATH="$NPM_PACKAGES/share/man:$(manpath)"

# Base16 Shell
# BASE16_SHELL="$HOME/dotfiles/base16-shell/base16-eighties.dark.sh"
# [[ -s $BASE16_SHELL ]] && source $BASE16_SHELL


#source ~/DotsMine/aliases.zsh


if [[ -r ~/.local/lib/python2.7/site-packages/powerline/bindings/zsh/powerline.zsh ]]; then
    source ~/.local/lib/python2.7/site-packages/powerline/bindings/zsh/powerline.zsh
fi


#!/bin/bash
# add this to your bashrc/zshrc
function _current_epoch {
  echo "$(($(date +%s) / 60 / 60 / 24))"
}

function _check_updates {
  (
    flock -n 9 || return # one concurrent update process at the time
    local ignored_pkgs="^linux"
    #local updates=`wc -l < /var/log/pacman-updates.log`
    local updates=`grep -Ev $ignored_pkgs /var/log/pacman-updates.log | wc -l`
    if [ $updates -gt 0 ]; then
      echo -n "There are $updates updates. Upgrade? (y/n) [n] "
      read line
      if [ "$line" = Y ] || [ "$line" = y ]; then
        yaourt -Syu --aur
        pacman -Qu | sudo tee /var/log/pacman-updates.log >/dev/null
      fi
    fi
    echo "$(_current_epoch)" > $HOME/.pacman-update
  ) 9> ~/.pacman-update.lck
}

if [[ $- == *i* ]] && # only interactive shells
  [ -e /var/log/pacman-updates.log ] && # only after first update
  [ ! -e /var/lib/pacman/db.lck ]; then # not if pacman is running
  if [ -e .pacman-update ]; then
    read last_epoch < $HOME/.pacman-update
    if [[ -n "$last_epoch" ]]; then
      if [ $(($(_current_epoch) - $last_epoch)) -ge 1 ]; then
        _check_updates
      fi
    fi
    unset last_epoch
  else
    _check_updates
  fi
fi

# Coloured man pages
#man() {
#	env LESS_TERMCAP_mb=$'\E[01;31m' \
#		LESS_TERMCAP_md=$'\E[01;38;5;74m' \
#		LESS_TERMCAP_me=$'\E[0m' \
#		LESS_TERMCAP_se=$'\E[0m' \
#		LESS_TERMCAP_so=$'\E[31;5;246m' \
#		LESS_TERMCAP_ue=$'\E[0m' \
#		LESS_TERMCAP_us=$'\E[04;38;5;146m' \
#		man "$@"
#}

zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion::complete:cd::' tag-order '! users' -
zstyle ':completion::complete:-command-::' tag-order '! users' -
zstyle ':completion:*:corrections' format "- %d - (errors %e})"
zstyle ':completion:*:default' list-prompt '%S%M matches%s'
zstyle ':completion:*:descriptions' format "- %d -"
zstyle ':completion:*:*:*:*:hosts' list-colors '=*=30;41'
zstyle ':completion:*:kill:*:processes' command "ps x"
zstyle ':completion:*:manuals' separate-sections true
zstyle ':completion:*' cache-path ~/.zsh/cache
zstyle ':completion:*' group-name ''
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' use-cache on
zstyle -e ':completion:*:approximate:*' max-errors 'reply=( $(( ($#PREFIX + $#SUFFIX) / 3 )) )'

#Wal!
(wal -R &)

#toilet -f circle -F gay "V A P O R  W A V E" && neofetch

#toilet -f 3d -F gay  "V A P O R W A V E" | lolcat

#toilet -f 3D-ASCII.flf --metal wow | lolcat
export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=on -Dswing.aatext=true'

echo "fuck man you need help" | cowsay | lolcat

echo "like yesterday" | lolcat


