# dotfileのリポジトリ  

## 開発環境
ubuntu22.04  
vim8.2  
zsh 5.8.1  
fzf  
tmux  
ranger

### Vim
```
sudo apt install vim
```

### zsh
```
sudo apt install zsh
```

### fzf
```
sudo apt install fzf
```

### tmux
```
sudo apt install tmux
```

### ranger
```
sudo apt-get install ranger w3m lynx highlight atool mediainfo xpdf caca-utils
ranger --copy-config=all
```

## dotfilesLink.sh
```
sh dotfilesLink.sh
```
を実行すると、dotfileのシンボリックオペレーションが作成される。

## dein.vimをインストールする
[dein.vim](https://github.com/Shougo/dein.vim)とは、vimのプラグインマネージャである。  
インストール方法  
```
wget https://raw.githubusercontent.com/Shougo/dein-installer.vim/master/installer.sh
sh installer.sh
```
これでdein.vimがインストールされて、vim起動時に.vimrcに書かれているプラグインが自動でダウンロードされる。  
インストーラー:https://github.com/Shougo/dein-installer.vim  

## 必要なフォント
fontは[powerline fonts](https://github.com/powerline/fonts)と[Nerd Fonts](https://github.com/ryanoasis/nerd-fonts)(アイコン用)が必要  
### powerline fonts
```
sudo apt-get install fonts-powerline
```
### Nerd Fonts
```
git clone --filter=blob:none --sparse git@github.com:ryanoasis/nerd-fonts
cd nerd-fonts
git sparse-checkout add patched-fonts/JetBrainsMono
bash install.sh
```
## zshプラグイン
zshのプラグインには[ohmyzsh](https://github.com/ohmyzsh/ohmyzsh)  
oh-my-zshでプラグインを入れるときは  
```
git clone https://github.com/zsh-users/plugin_name ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/plugin_name
```
