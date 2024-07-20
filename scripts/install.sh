#!/bin/bash
function main {

    set -euo pipefail

    # check dotfiles path
    if [ ! -d $HOME/dotfiles/ ]; then
        git clone https://github.com/yudai0804/dotfiles.git $HOME/dotfiles
    fi

    cd $HOME/dotfiles/scripts

    # とりあえずupdateとupgrade
    sudo apt update
    sudo apt upgrade -y

    sudo apt install -y curl

    # 開発環境系をインストール

    # gcc
    sudo apt install -y gcc
    # ac-library
    if [ ! -d $HOME/ac-library ]; then
        git clone https://github.com/atcoder/ac-library.git ~/ac-library
    fi

    # python
    # python3-pipを入れる
    sudo apt install -y python3
    sudo apt install -y python3-pip
    # GUI用にpython3-tkを入れる
    sudo apt install -y python3-tk

    # nodejsとnpm
    # npmでインストールした最新バージョンのnodejsとnpmが存在していないときにのみ実行する
    if [ ! -f "/usr/local/bin/node" ] || [ ! -f "/usr/local/bin/npm" ]; then
        # aptでnodejsとnpmをインストール
        sudo apt install -y nodejs npm

        # npmでnodeをインストール
        sudo npm install n -g
        sudo n stable
    fi

    if [ -f "/usr/bin/node" ] || [ -f "/usr/bin/npm" ]; then
        # 古いnodejsを削除
        sudo apt purge -y nodejs npm
        sudo apt autoremove -y
    fi

    # rust
    if [ ! -f $HOME/.cargo/bin/cargo ]; then
        curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
    fi

    # octave
    sudo apt install -y octave

# Docker
# if [ ! -f /usr/bin/docker ]; then
        # TODO Dockerのインストールを書く
# fi

    # 便利ツール

    # vim関連
    # もともと入っているvimを消してvim-gtkを入れる
    # 入れなおす理由はvim-gtkはclipboardに対応しているから
    sudo apt purge -y vim
    sudo apt install -y vim-gtk3
    mkdir $HOME/.vim/colors -p
    # monokaiをインストール
    if [ ! -f $HOME/.vim/colors/molokai.vim ]; then
        curl -o $HOME/.vim/colors/molokai.vim https://raw.githubusercontent.com/tomasr/molokai/master/colors/molokai.vim
    fi
    # ranger
    sudo apt install -y ranger w3m lynx highlight atool mediainfo xpdf caca-utils
    # デフォルトで作られるrangerのconfigを削除
    rm -rf $HOME/.config/ranger
    # xclip
    if [ $XDG_SESSION_TYPE = "wayland" ]; then
        sudo apt install -y wl-clipboard
    else
        # wayland以外のときはWSL環境やCLI環境のことも考慮してxclipをインストールする
        sudo apt install -y xclip
    fi

    # ascii
    sudo apt install -y ascii
    # neofetch
    sudo apt install -y neofetch
    # lazygit
    if [ ! -f /usr/local/bin/lazygit ]; then
        LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
        curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
        tar xf lazygit.tar.gz lazygit
        sudo install lazygit /usr/local/bin

        rm -rf lazygit lazygit.tar.gz
    fi
    # bash

    # local用ファイル作成
    touch $HOME/.bashrc_local
    # git-promptをダウンロード
    if [ ! -f $HOME/.git-prompt.sh ]; then
        curl -o $HOME/.git-prompt.sh \
            https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh
    fi

    # 各種configをdotfileからコピー
    ./link.sh

    # autoremove
    sudo apt autoremove -y

    return 0
}

main
