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

autoload -Uz compinit && compinit
autoload -Uz colors && colors
autoload -Uz add-zsh-hook

bindkey "^[[3~" delete-char
bindkey '^I'   complete-word       # tab          | complete
bindkey '^[[Z' autosuggest-accept  # shift + tab  | autosugges
