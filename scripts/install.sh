#!/bin/bash
function main {

    set -euo pipefail

    # figlet -f slant "Yudai0804's dotfiles"
    
    echo -e '\e[35;1m
__  __          __      _ ____  ____  ____  __ __ _      
\ \/ /_  ______/ /___ _(_) __ \( __ )/ __ \/ // /( )_____
 \  / / / / __  / __ `/ / / / / __  / / / / // /_|// ___/
 / / /_/ / /_/ / /_/ / / /_/ / /_/ / /_/ /__  __/ (__  ) 
/_/\__,_/\__,_/\__,_/_/\____/\____/\____/  /_/   /____/  
                                                         
       __      __  _____ __         
  ____/ /___  / /_/ __(_) /__  _____
 / __  / __ \/ __/ /_/ / / _ \/ ___/
/ /_/ / /_/ / /_/ __/ / /  __(__  ) 
\__,_/\____/\__/_/ /_/_/\___/____/  
                                    
\e[m'
    echo "start install scripts."

    # とりあえずupdateとupgrade
    sudo apt update
    sudo apt upgrade -y

    if [ -Z "$(which git)" ]; then
        sudo apt install -y git
    fi

    # check dotfiles path
    if [ ! -d $HOME/dotfiles/ ]; then
        git clone https://github.com/yudai0804/dotfiles.git $HOME/dotfiles
    fi

    cd $HOME/dotfiles/scripts
    # 各種configをdotfileからコピー
    ./link.sh
    source $HOME/.bashrc

    if [ -z "$(which curl)" ]; then
        sudo apt install -y curl
    fi

    # 開発環境系をインストール

    # gcc
    if [ -z "$(which gcc)" ]; then
        sudo apt install -y gcc
    fi
    # ac-library
    if [ ! -d $HOME/ac-library ]; then
        git clone https://github.com/atcoder/ac-library.git ~/ac-library
    fi

    # python
    sudo apt install -y python3 python3-pip python3-venv
    # GUI用にpython3-tkを入れる
    sudo apt install -y python3-tk
    # pyenv
    if [ -z "$(which pyenv)" ]; then
        curl https://pyenv.run | bash
        export PYENV_ROOT="$HOME/.pyenv"
        command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
        eval "$(pyenv init -)"
    fi
    # poetry
    if [ -z "$(which poetry)" ]; then
        curl -sSL https://install.python-poetry.org | python3 -
    fi

    # voltaを使ってnodeをインストール
    if [ -z "$(which volta)" ]; then
        curl https://get.volta.sh | bash
        export VOLTA_HOME="$HOME/.volta"
        export PATH="$VOLTA_HOME/bin:$PATH"
        volta install node@latest
    fi


    # rust
    if [ -z "$(which cargo)" ]; then
        curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
        export PATH=$HOME/.cargo/bin:$PATH
        rustup update
        # cargo binstall
        curl -L --proto '=https' --tlsv1.2 -sSf https://raw.githubusercontent.com/cargo-bins/cargo-binstall/main/install-from-binstall-release.sh | bash
    fi

    # octave
    if [ -z "$(which octave)" ]; then
        sudo apt install -y octave octave-signal
    fi

    # tool

    # fzf
    if [ -z "$(which fzf)" ]; then
        # 参考:https://github.com/junegunn/fzf/tree/master
        git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
        # allオプションをつけることで対話形式を避ける
        ~/.fzf/install --all
    fi
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
    # yazi
    if [ -z "$(which yazi)" ]; then
        # cargo install --locked yazi-fm yazi-cli
        # yaziに使うものをインストール
        sudo apt install -y file jq
        cargo binstall yazi-fm yazi-cli -y
    fi
    # delta
    if [ -z "$(which delta)" ]; then
        cargo binstall git-delta -y
    fi
    # lazydocker
    if [ -z "$(which lazydocker)" ]; then
        curl https://raw.githubusercontent.com/jesseduffield/lazydocker/master/scripts/install_update_linux.sh | bash
    fi
    # xclip
    if [ ${XDG_SESSION_TYPE-} = "wayland" ]; then
        sudo apt install -y wl-clipboard
    else
        # wayland以外のときはWSL環境やCLI環境のことも考慮してxclipをインストールする
        sudo apt install -y xclip
    fi

    # ascii
    if [ -z "$(which ascii)" ]; then
        sudo apt install -y ascii
    fi
    # neofetch
    if [ -z "$(which neofetch)" ]; then
        sudo apt install -y neofetch
    fi
    # tree
    if [ -z "$(which tree)" ]; then
        sudo apt install -y tree
    fi
    # htop
    if [ -z "$(which htop)" ]; then
        sudo apt install -y htop
    fi
    # bottom
    if [ -z "$(which btm)" ]; then
        cargo binstall -y btm
    fi
    # figlet
    if [ -z "$(which figlet)" ]; then
        sudo apt install -y figlet
    fi
    # lolcat
    if [ -z "$(which lolcat)" ]; then
        sudo apt install -y lolcat
    fi
    # lazygit
    if [ -z "$(which lazygit)" ]; then
        LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
        curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
        tar xf lazygit.tar.gz lazygit
        sudo install lazygit /usr/local/bin

        rm -rf lazygit lazygit.tar.gz
    fi

    # bash

    # local用ファイル作成
    touch $HOME/.bashrc_local
    # git-completionをダウンロード
    if [ ! -f $HOME/.git-completion.sh ]; then
        curl -o $HOME/.git-completion.sh \
            https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash
    fi
    # git-promptをダウンロード
    if [ ! -f $HOME/.git-prompt.sh ]; then
        curl -o $HOME/.git-prompt.sh \
            https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh
    fi

    # 各種configをdotfileからコピー
    # 念の為再度実行
    ./link.sh

    # autoremove
    sudo apt autoremove -y

    return 0
}

main
