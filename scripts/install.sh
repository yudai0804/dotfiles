#!/bin/bash

cd `dirname $0`
# 処理がエラーとなったら中断
set -e
# パイプライン内のコマンドがエラーとなったら中断
set -o pipefail
# 変数の設定漏れを防止
set -u

# とりあえずupdateとupgrade
sudo apt update
sudo apt upgrade -y

# 開発環境系をインストール

# gcc
sudo apt install gcc -y
# ac-library
git clone https://github.com/atcoder/ac-library.git ~/ac-library

# python
# python3-pipを入れる
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

# octave
sudo apt install octave -y

# 便利ツール

# vim関連
# もともと入っているvimを消してgtk-vimを入れる
# 入れなおす理由はgtk-vimはclipboardに対応しているから
sudo apt purge vim -y
sudo apt install gtk-vim -y
mkdir ~/.vim/colors -p
# monokaiをインストール
rm -rf molokai
git clone https://github.com/tomasr/molokai.git
mv molokai/colors/molokai.vim ~/.vim/colors/
rm -rf molokai
# ranger
sudo apt install ranger w3m lynx highlight atool mediainfo xpdf caca-utils -y
# デフォルトで作られるrangerのconfigを削除
rm -rf ~/.config/ranger
# xclip
sudo apt install xclip -y
# ascii
sudo apt install ascii -y
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
bash link.sh
