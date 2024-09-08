#!/bin/bash
mkdir -p ~/.config

ln -sfn ~/dotfiles/.config/lazygit ~/.config/lazygit
ln -sfn ~/dotfiles/.config/nvim ~/.config/nvim
ln -sfn ~/dotfiles/.config/ranger ~/.config/ranger
ln -sfn ~/dotfiles/.config/wezterm ~/.config/wezterm

ln -sf ~/dotfiles/.gitconfig ~/.gitconfig
ln -sf ~/dotfiles/.zshrc ~/.zshrc

ln -sf ~/dotfiles/.bashrc ~/.bashrc
ln -sf ~/dotfiles/.vimrc ~/.vimrc

ln -sf ~/dotfiles/.octaverc ~/.octaverc

mkdir -p ~/.config/Code/User

ln -sf ~/dotfiles/.config/Code/User/settings.json ~/.config/Code/User/settings.json
