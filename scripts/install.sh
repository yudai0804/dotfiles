#!/bin/bash
function main {

set -euxo pipefail

cd "$(dirname "$0")"

# check dotfiles path
if [ $(pwd) != $HOME/dotfiles/scripts ]; then
	echo "dotfiles path invalid."
    echo "You have to clone to "$HOME/dotfiles""
    echo "pwd=$(pwd)"
	return 1
 fi

# とりあえずupdateとupgrade
sudo apt update
sudo apt upgrade -y

sudo apt install curl -y

# 開発環境系をインストール

# gcc
sudo apt install gcc -y
# ac-library
if [ ! -d $HOME/ac-library ]; then
    git clone https://github.com/atcoder/ac-library.git ~/ac-library
fi

# python
# python3-pipを入れる
sudo apt install python3 -y
sudo apt install python3-pip -y
# GUI用にpython3-tkを入れる
sudo apt install python3-tk -y

# nodejsとnpm
# aptでnodejsとnpmをインストール
sudo apt install nodejs npm -y
# npm installで最新のnodejsを入れる
sudo npm install n -g
# 古いnodejsを削除
sudo n stable
sudo apt purge -y nodejs npm

# rust
if [ ! -e $HOME/.cargo/bin/cargo]; then
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
fi

# octave
sudo apt install octave -y

# Docker
# if [ ! -e /usr/bin/docker ]; then
    # TODO Dockerのインストールを書く
# fi

# 便利ツール

# vim関連
# もともと入っているvimを消してvim-gtkを入れる
# 入れなおす理由はvim-gtkはclipboardに対応しているから
sudo apt purge vim -y
sudo apt install vim-gtk3 -y
mkdir ~/.vim/colors -p
# monokaiをインストール
if [! -e ~/.vim/colors/molokai.vim]; then
    curl -o ~/.vim/colors/molokai.vim https://raw.githubusercontent.com/tomasr/molokai/master/colors/molokai.vim
fi
# ranger
sudo apt install ranger w3m lynx highlight atool mediainfo xpdf caca-utils -y
# デフォルトで作られるrangerのconfigを削除
rm -rf ~/.config/ranger
# xclip
sudo apt install xclip -y
# ascii
sudo apt install ascii -y
# neofetch
sudo apt install neofetch -y
# lazygit
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar xf lazygit.tar.gz lazygit
sudo install lazygit /usr/local/bin

rm -rf lazygit lazygit.tar.gz

# bash

# local用ファイル作成
touch ~/.bashrc_local
# git-promptをダウンロード
curl -o ~/.git-prompt.sh \
    https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh
# 各種configをdotfileからコピー
./link.sh

# autoremove
sudo apt autoremove -y

return 0
}

main
