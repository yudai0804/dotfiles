
### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit
### End of Zinit's installer chunk

# prompt theme
zinit ice pick"async.zsh" src"pure.zsh"
zinit light sindresorhus/pure

zinit ice wait'!0'; zinit light zsh-users/zsh-syntax-highlighting
zinit ice wait'!0'; zinit light zsh-users/zsh-autosuggestions
zinit ice wait'!0'; zinit light zsh-users/zsh-completions
# 補完で小文字でも大文字にマッチさせる
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
# 補完候補を一覧表示したとき、Tabや矢印で移動できるようにする
zstyle ':completion:*:default' menu select=1

# fzf
source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh

export PATH="${PATH}:$HOME/.local/bin/nvim-linux64/bin"

export EDITOR=nvim
export LANG=ja_JP.UTF-8
KEYTIMEOUT=1
# viのキーバインド
bindkey -v 
# カッコの対応などを自動的に補完する
setopt auto_param_keys
# コマンドのスペルチェックをする
setopt correct
# コマンドライン全てのスペルチェックをする
setopt correct_all

export HISTFILE=$HOME/.zsh-history
export HISTSIZE=10000
export SAVEHIST=100000

setopt hist_expire_dups_first # 履歴を切り詰める際に、重複する最も古いイベントから消す
setopt hist_ignore_all_dups   # 履歴が重複した場合に古い履歴を削除する
setopt hist_ignore_dups       # 前回のイベントと重複する場合、履歴に保存しない
setopt hist_save_no_dups      # 履歴ファイルに書き出す際、新しいコマンドと重複する古いコマンドは切り捨てる
setopt share_history          # 全てのセッションで履歴を共有する

autoload -Uz compinit && compinit
autoload -Uz colors && colors
autoload -Uz add-zsh-hook

bindkey "^[[3~" delete-char
bindkey '^I'   complete-word       # tab          | complete
bindkey '^[[Z' autosuggest-accept  # shift + tab  | autosugges

alias ls='ls --color=auto' 
alias ll='ls -alF --color=auto'

alias ga='git add'
alias gd='gi diff'
alias gst='git status'
alias gp='git push'
alias gpush='git push'
alias gpull='git pull'
alias gb='git branch'
alias gco='git checkout'
alias gc='git commit'

alias g="g++ -std=c++20 -g -Wall -Wextra -Wshadow -Wconversion -Wfloat-equal -Wno-char-subscripts -ftrapv -fsanitize=address,undefined -fno-omit-frame-pointer -fno-sanitize-recover -I $HOME/ac-library"
alias g+="g++ -std=c++20 -O2 -Wall -Wextra -I $HOME/ac-library"

# rangerが多重に起動するのを防止する
# https://qiita.com/ssh0/items/fe85da119c93333ba34e

function r() {
   if [ -z "$RANGER_LEVEL" ]; then
       /usr/bin/ranger $@
   else
       exit
   fi
}
