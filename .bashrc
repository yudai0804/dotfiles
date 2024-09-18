# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# ===== ALIAS =====

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

function pbcopy {
    if [ ${XDG_SESSION_TYPE-} = "wayland" ]; then
        if [ -n "$(which wl-copy)" ]; then
            wl-copy
        else
            echo "wl-copy not found.\nPlease install wl-clipboard."
        fi
    else
        # WSL環境やCLI環境のことを考慮して、wayland以外であれば、xclipを使うというようにする
        if [ -n "$(which xclip)" ]; then
            xclip -selection clipboard
        else
            echo "xclip not found.\nPlease install xclip."
        fi
    fi
}

function pbpaste {
    if [ ${XDG_SESSION_TYPE-} = "wayland" ]; then
        if [ -n "$(which wl-paste)" ]; then
            wl-paste
        else
            echo "wl-paste not found.\nPlease install wl-clipboard."
        fi
    else
        # WSL環境やCLI環境のことを考慮して、wayland以外であれば、xclipを使うというようにする
        if [ -n "$(which xclip)" ]; then
            xclip -selection clipboard -o
        else
            echo "xclip not found.\nPlease install xclip."
        fi
    fi
}

alias copy='pbcopy'
alias clip='pbcopy'
alias paste='pbpaste'

if [ -n "$(which kwrite)" ]; then
    alias notepad='kwrite'
fi

if [ -n "$(which dolphin)" ]; then
    alias explorer='dolphin'
fi

function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

alias yazi='y'

# ===== PROMPT =====

if [ -f ~/.git-prompt.sh ]; then
    source ~/.git-prompt.sh
fi
GIT_PS1_SHOWDIRTYSTATE=true
GIT_PS1_SHOWUNTRACKEDFILES=true
GIT_PS1_SHOWSTASHSTATE=true
GIT_PS1_SHOWUPSTREAM=auto

PS1='\[\033[32m\]\u@\h\[\033[00m\] \[\033[33m\]\w\[\033[36m\]$(__git_ps1 " (%s)")\[\033[00m\]\n\$ '

# ===== COMPLETION =====

if [ -f ~/.git-completion.sh ]; then
    source ~/.git-completion.sh
fi

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# ===== HISTORY =====

HISTSIZE=10000
HISTFILESIZE=10000
# Avoid duplicates
HISTCONTROL=ignoredups:erasedups
# When the shell exits, append to the history file instead of overwriting it
shopt -s histappend

# After each command, append to the history file and reread it
PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND$'\n'}history -a; history -c; history -r"
# ===== EXPORT =====

export EDITOR=vim
# for cargo
export PATH=$HOME/.cargo/bin:$PATH
# for pyenv
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
# for volta
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"

if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

# ===== OTHER =====

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# load local bashrc
if [ -f ~/.bashrc_local ]; then
    source ~/.bashrc_local
fi

# アスキーアートを表示する
# lolcatが入っていればレインボーで表示する(lolcatは動かない環境があるので注意)
print_aa() {
    if [ -n "$(which figlet)" ]; then
        if [ -n "$(which lolcat)" ]; then
            figlet -f slant "Welcome" | lolcat
        else
            figlet -f slant "Welcome"
        fi
    fi
}

print_aa

