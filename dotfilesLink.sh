#!/bin/sh
mkdir -p ~/.config/ranger
mkdir -p ~/.config/alacritty
mkdir -p ~/.config/i3
mkdir -p ~/.config/wezterm
ln -sf ~/dotfiles/.gitconfig ~/.gitconfig
ln -sf ~/dotfiles/.xprofile ~/.xprofile
ln -sf ~/dotfiles/.zshrc ~/.zshrc
ln -sf ~/dotfiles/.config/ranger/rifle.conf ~/.config/ranger/rifle.conf
ln -sf ~/dotfiles/.config/ranger/rc.conf ~/.config/ranger/rc.conf
ln -sf ~/dotfiles/.config/alacritty/alacritty.yml ~/.config/alacritty/alacritty.yml
ln -sf ~/dotfiles/.config/i3/config ~/.config/i3/config
ln -sf ~/dotfiles/.config/i3/i3-smart-resize ~/.config/i3/i3-smart-resize
ln -sf ~/dotfiles/.config/wezterm/wezterm.lua ~/.config/wezterm/wezterm.lua
