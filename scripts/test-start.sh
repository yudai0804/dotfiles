apt-get update
apt-get install -y sudo
apt-get install -y git
if [ ! -d $HOME/dotfiles ]; then
    git clone https://github.com/yudai0804/dotfiles.git $HOME/dotfiles
fi
cd $HOME/dotfiles
./scripts/install.sh
