export ZSH=$HOME/.oh-my-zsh
export EDITOR=vim
export PATH="/home/yudai/.cache/git-fuzzy/bin:$PATH"
# zsh関連
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="agnoster"

plugins=(git zsh-syntax-highlighting zsh-autosuggestions)
# 読み込み
source $ZSH/oh-my-zsh.sh
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# alias
alias h='fc -lt '%F %T' 1'

alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

alias g='git'
alias ga='git add'
alias gd='git diff'
alias gs='git status'
alias gp='git push'
alias gb='git branch'
alias gst='git status'
alias gco='git checkout'
alias gf='git fetch'
alias gc='git commit'

alias v='vim'
alias s='sudo'

# キーバインド
# KEYTIMEOUTを短くする
KEYTIMEOUT=1
# viのキーバインド
bindkey -v 
# カッコの対応などを自動的に補完する
setopt auto_param_keys
# コマンドのスペルチェックをする
setopt correct
# コマンドライン全てのスペルチェックをする
setopt correct_all
# sudo の後ろでコマンド名を補完する
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin \
                   /usr/sbin /usr/bin /sbin /bin /usr/X11R6/bin
# setopt auto_pushd
# 長いので、自分のユーザー名とPCの名前を出さないようにする
prompt_context () { }

# Vim上でC-qやC-sを使えるようにするおまじない
stty -ixon
# -----------------------------
# History
# -----------------------------
# 基本設定
HISTFILE=$HOME/.zsh-history
HISTSIZE=10000
SAVEHIST=100000

setopt hist_expire_dups_first # 履歴を切り詰める際に、重複する最も古いイベントから消す
setopt hist_ignore_all_dups   # 履歴が重複した場合に古い履歴を削除する
setopt hist_ignore_dups       # 前回のイベントと重複する場合、履歴に保存しない
setopt hist_save_no_dups      # 履歴ファイルに書き出す際、新しいコマンドと重複する古いコマンドは切り捨てる
setopt share_history          # 全てのセッションで履歴を共有する

# autosuggest関連の設定
TERM=xterm-256color
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=23"
# tabでautosuggest,shitf + tabで通常補完
#ref:https://github.com/zsh-users/zsh-autosuggestions/issues/532
bindkey '^I' autosuggest-accept

fcd() {
    if [[ "$#" != 0 ]]; then
        builtin cd "$@";
        return
    fi
    while true; do
        local lsd=$(echo '..' & ls -Ap | grep '/$' | sed 's;/$;;')
        local dir="$(printf '%s\n' "${lsd[@]}" |
            fzf --reverse --preview '
                __cd_nxt="$(echo {})";
                __cd_path="$(echo $(pwd)/${__cd_nxt} | sed "s;//;/;")";
                echo $__cd_path;
                echo;
                ls -p --color=always "${__cd_path}";
        ')"
        [[ ${#dir} != 0 ]] || return 0
        builtin cd "$dir" &> /dev/null
    done
}

# ref:https://qiita.com/reviry/items/e798da034955c2af84c5
fadd() {
  local out q n addfiles
  while out=$(
      git status --short |
      awk '{if (substr($0,2,1) !~ / /) print $2}' |
      fzf-tmux --multi --ansi --exit-0 --expect=ctrl-d --preview="echo {} | awk '{print \$2}' | xargs git diff --color" | awk 'print $2'); do
   q=$(head -1 <<< "$out")
    n=$[$(wc -l <<< "$out") - 1]
    addfiles=(`echo $(tail "-$n" <<< "$out")`)
    [[ -z "$addfiles" ]] && continue
    if [ "$q" = ctrl-d ]; then
      git diff --color=always $addfiles | less -R
    else
      git add $addfiles
    fi
  done
  echo "fadd coplete"
}

fd() {
  preview="git diff $@ --color=always -- {-1}"
  git diff $@ --name-only | fzf -m --ansi --preview $preview
}


# fbr - checkout git branch (including remote branches)
fbr() {
  local branches branch
  branches=$(git branch --all | grep -v HEAD) &&
  branch=$(echo "$branches" |
           fzf-tmux -d $(( 2 + $(wc -l <<< "$branches") )) +m) &&
 git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
}

# fshow - git commit browser
fshow()
{
  git log --graph --all --color=always --format="%C(auto)%h%d %s %C(bold)%cr"  | \
   fzf --ansi --no-sort --reverse --tiebreak=index --preview \
   'f() { set -- $(echo -- "$@" | grep -o "[a-f0-9]\{7\}"); [ $# -eq 0 ] || git show --color=always $1 ; }; f {}' \
   --bind "j:down,k:up,alt-j:preview-down,alt-k:preview-up,ctrl-f:preview-page-down,ctrl-b:preview-page-up,q:abort,ctrl-m:execute:
                (grep -o '[a-f0-9]\{7\}' | head -1 |
                xargs -I % sh -c 'git show --color=always % | less -R') << 'FZF-EOF'
                {}
    FZF-EOF" \
    --preview-window='right,50%,border-left'
}

# rangerが多重に起動するのを防止する
# https://qiita.com/ssh0/items/fe85da119c93333ba34e

function r() {
   if [ -z "$RANGER_LEVEL" ]; then
       /usr/bin/ranger $@
   else
       exit
   fi
}
[ -n "$RANGER_LEVEL" ] && PS1="(RANGER) $PS1"
alias rng='ranger'
