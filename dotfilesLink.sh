#!/bin/sh
mkdir -p .vim
mkdir -p .config/ranger
mkdir -p .config/alacritty
mkdir -p .config/i3
ln -sf ~/dotfiles/.gitconfig ~/.gitconfig
ln -sf ~/dotfiles/.vimrc ~/.vimrc
ln -sf ~/dotfiles/.vim/coc-settings.json ~/.vim/coc-settings.json
ln -sf ~/dotfiles/.zshrc ~/.zshrc
ln -sf ~/dotfiles/.tmux.conf ~/.tmux.conf
ln -sf ~/dotfiles/ranger/rifle.conf ~/.config/ranger/rifle.conf
ln -sf ~/dotfiles/ranger/rc.conf ~/.config/ranger/rc.conf
ln -sf ~/dotfiles/alacritty.yml ~/.config/alacritty/alacritty.yml
ln -sf ~/dotfiles/i3/config ~/.config/i3/config
