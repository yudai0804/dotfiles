# dotfileのリポジトリ  
ubuntu22.04  
vim

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
