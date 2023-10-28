export EDITOR=vim
export LANG=ja_JP.UTF-8
autoload -Uz compinit && compinit
autoload -Uz colors && colors
autoload -Uz add-zsh-hook
source ${HOME}/dotfiles/zsh/prompt.zsh
source ${HOME}/dotfiles/zsh/history.zsh
source ${HOME}/dotfiles/zsh/alias.zsh
