#!/bin/bash

[[ $- == *i* ]] && stty -ixon

shopt -s autocd #Allows you to cd into directory merely by typing the directory name.
HISTSIZE=1000
HISTFILESIZE=2000#
export HISTIGNORE="clear:bg:fg:cd:cd -:cd ..:exit:date:w:* --help:ls:l:ll:lll"
# export PS1="\[$(tput bold)\]\[$(tput setaf 1)\][\[$(tput setaf 3)\]\u\[$(tput setaf 2)\]@\[$(tput setaf 4)\]\h \[$(tput setaf 5)\]\W\[$(tput setaf 1)\]]\[$(tput setaf 7)\]\\$ \[$(tput sgr0)\]"
# bind '"\C-z" "fg\015"'
# bind '"\C-f" "tmuxa\n"'
# bind '"\C-t" "tmuxs\n"'

[ -f "$HOME/.config/shortcutrc" ] && source "$HOME/.config/shortcutrc" # Load shortcut aliases
[ -f "$HOME/.config/aliasrc" ] && source "$HOME/.config/aliasrc"

alias config='/usr/bin/git --git-dir=/home/kkmp/.cfg/ --work-tree=/home/kkmp'


source /home/kkmp/.config/broot/launcher/bash/br
eval "$(starship init bash)"
. "$HOME/.cargo/env"


# pnpm
export PNPM_HOME="/home/kkmp/.local/share/pnpm"
export PATH="$PNPM_HOME:$PATH"
# pnpm end