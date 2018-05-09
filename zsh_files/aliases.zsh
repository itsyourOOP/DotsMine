
# NeoVim
#alias vim="nvim"
#alias vi="nvim"
#alias v="nvim"

# Tmux
alias tmux="tmux -2"

# Vagrant
alias vu='vagrant up'
alias vs='vagrant ssh'
alias vh='vagrant halt'
alias vss='vagrant status'

## Git
alias gst="git status -s"
alias ga="git add"
alias gg="git log --oneline --graph --decorate --color"
unalias gd
alias gd="git diff"

## Zshmarks
alias g="jump"
alias s="bookmark"
alias d="deletemark"
alias p="showmarks"
alias l="showmarks"

# Find files
f() {
    ag --smart-case --hidden -g $1
}

# Remove orphans packages
orphans() {
    sudo pacman -Rns $(pacman -Qtdq)
}

# Remaining todos in the current folder
todos() {
    autoload colors; colors;
    echo "You have: ($fg_bold[red]`ag -i @todo . | wc -l`$fg[white]) todos left."
}

# bandwidth
bt() {
    wget http://cachefly.cachefly.net/100mb.test -O /dev/null
}

# from old
alias yget="yaourt -S"
alias yrem="yaourt -R"
alias yupdate="yaourt -Syuu && pacaur -u"
alias up='cd ..'
alias weather="curl wttr.in/Pittsburgh"
alias moonPhase="curl wttr.in/Moon"
alias weatherAndMoonPhase="weather && moonPhase"
alias poweroff="sudo shutdown -h now"
alias mpsyt="sudo mpsyt"
alias orochi="sudo orochi"
alias whenPacmanActsUp="sudo rm /var/lib/pacman/db.lck"
alias pip2="sudo pip2"

#from new
alias fireplace='~/sources/fireplace/fireplace'
alias set-bg='~/DotsMine/scripts/set-bg'
alias edit_alias='nano ~/DotsMine/zsh_files/aliases.zsh'
alias source_alias='source ~/DotsMine/zsh_files/aliases.zsh && echo "alias sourced"'
alias es_alias='edit_alias && source_alias'
alias ech='clear'
alias kek='cd && clear'
alias su_nano='sudo nano'
alias rtv='rtv --enable-media'
alias git='hub'
alias edit_zshrc='nano ~/DotsMine/zsh_files/.zshrc'
alias accessThoth='ssh azh15@thoth.cs.pitt.edu'
alias editWallpaper='nano ~/DotsMine/scripts/set-bg'
alias logisim='java -jar ~/College/Sophomore\ Year/Assembly\ Language/Software/logisim-generic-2.7.1.jar'
alias MarsMips='java -jar ~/College/Sophomore\ Year/Assembly\ Language/Software/Mars4_5_0447c.jar'
alias polybar_config='nano ~/.config/polybar/config'
alias Digital='java -jar ~/College/Sophomore\ Year/Assembly\ Language/Software/Digital/Digital.jar'
alias keep="npm start --prefix '~/sources/keep'"
alias sftpThoth='sftp azh15@thoth.cs.pitt.edu'
alias edit-Mopidy-conf='su_nano /etc/mopidy/mopidy.conf'
alias rtv='rtv --enable-media'
alias scpThoth='scp azh15@thoth.cs.pitt.edu'
alias pip3="sudo pip3"
alias cp-Mopidy-conf='cp /etc/mopidy/mopidy.conf ~/.config/mopidy/mopidy.conf && echo "config copied to local"'
alias alias-list='cat ~/DotsMine/zsh_files/aliases.zsh'
