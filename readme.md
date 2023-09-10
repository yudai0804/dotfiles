# dotfileのリポジトリ  

## 開発環境
ubuntu22.04  
vim8.2  
zsh 5.8.1  
tmux
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

## zshプラグイン
zshのプラグインには[ohmyzsh](https://github.com/ohmyzsh/ohmyzsh)
