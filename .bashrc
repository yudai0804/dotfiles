# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

HISTSIZE=10000
HISTFILESIZE=10000
# Avoid duplicates
HISTCONTROL=ignoredups:erasedups
# When the shell exits, append to the history file instead of overwriting it
shopt -s histappend

# After each command, append to the history file and reread it
PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND$'\n'}history -a; history -c; history -r"

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

# if [ "$color_prompt" = yes ]; then
    # PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
# else
    # PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
# fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    # alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
# alias ll='ls -alF'
# alias la='ls -A'
# alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

alias ls='ls --color=auto' 
alias ll='ls -alF --color=auto'

alias ga='git add'
alias gaa='git add -A'
alias gd='gi diff'
alias gst='git status'
alias gP='git push'
alias gp='git pull'
alias gb='git branch'
alias gco='git checkout'
alias gc='git commit'
alias gcm='git commit -m'
alias gu='git add -A && git commit -m "update"'

alias python='python3'
alias p='python3'

alias lzg='lazygit'

alias g="g++ -std=c++20 -O2 -g -Wall -Wextra -Wshadow -Wconversion -Wfloat-equal -Wno-char-subscripts -ftrapv -fsanitize=address,undefined -fno-omit-frame-pointer -fno-sanitize-recover -I $HOME/ac-library -o a"
alias g+="g++ -std=c++20 -O2 -Wall -Wextra -I $HOME/ac-library -o a"

export EDITOR=vim

# for cargo
export PATH=$HOME/.cargo/bin:$PATH

source ~/.bashrc_local

if [ -f ~/.git-completion.sh ]; then
    source ~/.git-completion.sh
fi

if [ -f ~/.git-prompt.sh ]; then
    source ~/.git-prompt.sh
fi
GIT_PS1_SHOWDIRTYSTATE=true
GIT_PS1_SHOWUNTRACKEDFILES=true
GIT_PS1_SHOWSTASHSTATE=true
GIT_PS1_SHOWUPSTREAM=auto

PS1='\[\033[32m\]\u@\h\[\033[00m\] \[\033[33m\]\w\[\033[36m\]$(__git_ps1 " (%s)")\[\033[00m\]\n\$ '

function pbcopy {
    if [ ${XDG_SESSION_TYPE-} = "wayland" ]; then
        if [ -n $(which "wl-copy") ]; then
            wl-copy
        else
            echo "wl-copy not found.\nPlease install wl-clipboard."
        fi
    else
        # WSL環境やCLI環境のことを考慮して、wayland以外であれば、xclipを使うというようにする
        if [ -n $(which "xclip" ) ]; then
            xclip -selection clipboard
        else
            echo "xclip not found.\nPlease install xclip."
        fi
    fi
}

function pbpaste {
    if [ ${XDG_SESSION_TYPE-} = "wayland" ]; then
        if [ -n $(which "wl-paste") ]; then
            wl-paste
        else
            echo "wl-paste not found.\nPlease install wl-clipboard."
        fi
    else
        # WSL環境やCLI環境のことを考慮して、wayland以外であれば、xclipを使うというようにする
        if [ -n $(which "xclip" ) ]; then
            xclip -selection clipboard -o
        else
            echo "xclip not found.\nPlease install xclip."
        fi
    fi
}

# rangerが多重に起動するのを防止する
# https://qiita.com/ssh0/items/fe85da119c93333ba34e

function ranger() {
   if [ -z "$RANGER_LEVEL" ]; then
       /usr/bin/ranger $@
   else
       exit
   fi
}

alias r='ranger'
alias copy='pbcopy'
alias clip='pbcopy'
alias paste='pbpaste'

if [ -n $(which kwrite) ]; then
    alias notepad='kwrite'
fi

if [ -n $(which dolphin) ]; then
    alias explorer='dolphin'
fi

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

[ -f ~/z/z.sh ] && source ~/z/z.sh

# fd - cd to selected directory
fd() {
  local dir
  dir=$(find ${1:-.} -path '*/\.*' -prune \
                  -o -type d -print 2> /dev/null | fzf +m) &&
  cd "$dir"
}

# fda - including hidden directories
fda() {
  local dir
  dir=$(find ${1:-.} -type d 2> /dev/null | fzf +m) && cd "$dir"
}

# アスキーアートを表示する
# lolcatが入っていればレインボーで表示する(lolcatは動かない環境があるので注意)
print_aa() {
    if [ -n $(which figlet) ]; then
        if [ -n $(which lolcat) ]; then
            figlet -f slant "Welcome" | lolcat
        else
            figlet -f slant "Welcome"
        fi
    fi
}


print_aa
