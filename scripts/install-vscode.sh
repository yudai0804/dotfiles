#!/bin/bash
set -euo pipefail

# vscode
# 参考:https://code.visualstudio.com/docs/setup/linux
sudo apt-get install -y wget gpg
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" |sudo tee /etc/apt/sources.list.d/vscode.list > /dev/null
rm -f packages.microsoft.gpg
sudo apt install -y apt-transport-https
sudo apt update
sudo apt install -y code # or code-insiders
# extensionsをインストール
# ただし、ディレクトリの関係上ユーザーアカウントのときのみスクリプトが走るようにする
if [ $(whoami) != root ]; then
    ./scripts/install-vscode-extensions.sh
fi
