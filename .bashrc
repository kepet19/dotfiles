#!/bin/bash
stty -ixon # Disable ctrl-s and ctrl-q.
shopt -s autocd #Allows you to cd into directory merely by typing the directory name.
HISTSIZE= HISTFILESIZE= # Infinite history.
export PS1="\[$(tput bold)\]\[$(tput setaf 1)\][\[$(tput setaf 3)\]\u\[$(tput setaf 2)\]@\[$(tput setaf 4)\]\h \[$(tput setaf 5)\]\W\[$(tput setaf 1)\]]\[$(tput setaf 7)\]\\$ \[$(tput sgr0)\]"

[ -f "$HOME/.config/shortcutrc" ] && source "$HOME/.config/shortcutrc" # Load shortcut aliases
[ -f "$HOME/.config/aliasrc" ] && source "$HOME/.config/aliasrc"
alias config='/usr/bin/git --git-dir=/home/kkmp/.cfg/ --work-tree=/home/kkmp'
# source ~/.bash-powerline.sh
if [ -f /usr/lib/python3.7/site-packages/powerline/bindings/bash/powerline.sh ]; then
    source /usr/lib/python3.7/site-packages/powerline/bindings/bash/powerline.sh
fi
