# autoload -U colors && colors
# PS1="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%~%{$fg[red]%}]%{$reset_color%}$%b "
#
# History in cache directory:
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.cache/zsh/history
HISTORY_IGNORE="(ls|cd|pwd|exit|cd ..|lfcd|tmuxa|fg|config)"

# Path to your oh-my-zsh installation.
# export ZSH="/home/kkmp/.config/.oh-my-zsh"
# ZSH_THEME="robbyrussell"
# plugins=(git cargo pip systemd zsh-autosuggestions)
# source $ZSH/oh-my-zsh.sh
#
# Load aliases and shortcuts if existent.
[ -f "$HOME/.config/shortcutrc" ] && source "$HOME/.config/shortcutrc"
[ -f "$HOME/.config/aliasrc" ] && source "$HOME/.config/aliasrc"

autoload -U compinit
setopt autocd
# zstyle ':completion:*' menu select
zstyle ':completion:*' menu select 'm:{a-z}={A-Z}'
set completion-ignore-case on
zmodload zsh/complist
compinit

# Include hidden files in autocomplete:
_comp_options+=(globdots)
# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char
# bindkey '^R' history-incremental-search-backward

export KEYTIMEOUT=1

# Change Cd does matter case insentive
cd () {
  builtin cd "$@" 2>/dev/null && return
  emulate -L zsh
  setopt local_options extended_glob
  local matches
  matches=( (#i)${(P)#}(N/) )
  case $#matches in
    0) # There is no match, even case-insensitively. Try cdpath.
      if ((#cdpath)) &&
         [[ ${(P)#} != (|.|..)/* ]] &&
         matches=( $^cdpath/(#i)${(P)#}(N/) ) &&
         ((#matches==1))
      then
        builtin cd $@[1,-2] $matches[1]
        return
      fi
      # Still nothing. Let cd display the error message.
      builtin cd "$@";;
    1)
      builtin cd $@[1,-2] $matches[1];;
    *)
      print -lr -- "Ambiguous case-insensitive directory match:" $matches >&2
      return 3;;
  esac
}

# Change cursor shape for different vi modes.
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'

  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q'
  fi
}
zle -N zle-keymap-select

zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}
zle -N zle-line-init

# Use beam shape cursor on startup.
echo -ne '\e[5 q'
# Use beam shape cursor for each new prompt.
preexec() { echo -ne '\e[5 q' ;}

# Use lf to switch directories and bind it to ctrl-o
lfcd () {
    tmp="$(mktemp)"
    lf -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        rm -f "$tmp"
        if [ -d "$dir" ]; then
            if [ "$dir" != "$(pwd)" ]; then
                cd "$dir"
            fi
        fi
    fi
}
bindkey -s '^o' 'lfcd\n'  # zsh
# bindkey -s '^o' 'cd "$(xplr)"\n'  # zsh

# $1 (Optionally) - if present (value doesn't matter), this test checks if any containers exist. Else, if active (running) containers exis
__docker_pre_test() {
  if [[ -z "$1" ]] && [[ $(docker ps --format '{{.Names}}') ]]; then
    return 0;
  fi

  if [[ ! -z "$1" ]] && [[ $(docker ps -a --format '{{.Names}}') ]]; then
    return 0;
  fi

  echo "No containers found";
  return 1;
}

de() {
  __docker_pre_test
  if [ $? -eq 0 ]; then
    local name=$(docker ps --format '{{.Names}}' | fzf)

    if [ ! -z "$name" ]; then
      local command="$1"

      if [ -z "$command" ] && [ -f "$HOME/.docker-fuzzy-search-exec" ]; then
        command=$($HOME/.docker-fuzzy-search-exec "$name")
      fi

      if [ -z "$command" ]; then
        local imageName=$(docker inspect --format '{{.Config.Image}}' $name | sed -e 's/:.*$//g') #without version
        case "$imageName" in
          "mysql" | "bitnami/mysql" | "mysql/mysql-server" | "percona" | centos/mysql*)
            command='mysql -uroot -p$MYSQL_ROOT_PASSWORD'
          ;;

          "mongo" | "circleci/mongo")
            command='if [ -z "$MONGO_INITDB_ROOT_USERNAME" ]; then mongo; else mongo -u "$MONGO_INITDB_ROOT_USERNAME" -p "$MONGO_INITDB_ROOT_PASSWORD"; fi'
          ;;
          "bitnami/mongodb")
            command='if [ ! -z "$MONGODB_ROOT_PASSWORD" ]; then mongo -u root -p "$MONGODB_ROOT_PASSWORD"; elif [ ! -z $MONGODB_USERNAME ]; then mongo -u "$MONGODB_USERNAME" -p "$MONGODB_PASSWORD" "$MONGODB_DATABASE"; else mongo; fi'
          ;;
          centos/mongodb*)
            command='mongo -u "admin" -p "$MONGODB_ADMIN_PASSWORD" --authenticationDatabase admin'
          ;;

          "redis" | "circleci/redis" | "bitnami/redis" | centos/redis*)
            command='echo -n "Enter DB Number to connect to (^[1-9][0-9]?$): " && read dbNum && redis-cli -n $dbNum'
            if [[ "$imageName" == "bitnami/redis" ]] || [[ "$imageName" == "centos/redis"* ]]; then
              command="if [ -z \$REDIS_PASSWORD ]; then $command; else $command -a \"\$REDIS_PASSWORD\"; fi"
            fi
          ;;

          *)
            command='command $(command -v zsh || command -v bash || command -v ash || command -v sh)'
        esac

        command="sh -c '$command'"
      fi

      eval "docker exec -it $name $command"
    fi
  fi
}

# Clean Up User VIABELS

# Dot files 
alias config='/usr/bin/git --git-dir=/home/kkmp/.cfg/ --work-tree=/home/kkmp'

bindkey -s '^z' "fg\015"
bindkey -s '^f' "tmuxa\n"
# Load zsh-syntax-highlighting; should be last.
source /usr/share/fzf/completion.zsh
source /usr/share/fzf/key-bindings.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null
eval "$(navi widget zsh)"
eval "$(_kn init zsh)"
eval "$(starship init zsh)"
