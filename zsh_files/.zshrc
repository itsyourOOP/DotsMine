export TERM="termite"

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
#ZSH_THEME="powerlevel9k"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
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
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
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
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

#toilet -f 3D-ASCII.flf --metal wow | lolcat

# Coloured man pages
man() {
	env LESS_TERMCAP_mb=$'\E[01;31m' \
		LESS_TERMCAP_md=$'\E[01;38;5;74m' \
		LESS_TERMCAP_me=$'\E[0m' \
		LESS_TERMCAP_se=$'\E[0m' \
		LESS_TERMCAP_so=$'\E[31;5;246m' \
		LESS_TERMCAP_ue=$'\E[0m' \
		LESS_TERMCAP_us=$'\E[04;38;5;146m' \
		man "$@"
}

export PATH=$PATH:/$HOME/.composer/vendor/bin:.vendor/bin/:$HOME/bin:/usr/local/bin

PATH="$(ruby -e 'print Gem.user_dir')/bin:$PATH"
PATH="/root/.gem/ruby/2.3.0/bin:$PATH"

export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=on -Dswing.aatext=true'

export GBDKDIR=/opt/gbdk/

# NPM packages
NPM_PACKAGES="${HOME}/.npm-packages"
NODE_PATH="$NPM_PACKAGES/lib/node_modules:$NODE_PATH"
PATH="$NPM_PACKAGES/bin:$PATH"
# Unset manpath so we can inherit from /etc/manpath via the `manpath`
# # command
unset MANPATH # delete if you already modified MANPATH elsewhere in your config
MANPATH="$NPM_PACKAGES/share/man:$(manpath)"


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




source ~/aliases.zsh

wal -R

#"YOU NEED TO HELP YOURSELF" | lolcat
#toilet -t -f 6x10 "you need to help yourself" | lolcat

source /usr/share/zsh-theme-powerlevel9k/powerlevel9k.zsh-theme
set -o noclobber

#rescuetime &
echo "by the way, the C declaration program is 'cdecl'"
#xdg-settings set default-web-browser firefox.desktop
export BROWSER='/usr/bin/firefox'
echo 'by the way, rtm is the rememberthemilk terminal client'


PATH="/home/macrossneurology/perl5/bin${PATH:+:${PATH}}"; export PATH;
PERL5LIB="/home/macrossneurology/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/home/macrossneurology/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/home/macrossneurology/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/home/macrossneurology/perl5"; export PERL_MM_OPT;
