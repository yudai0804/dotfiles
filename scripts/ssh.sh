#!/bin/bash
set -euo pipefail
mkdir -p ~/.ssh
# generate ssh key
# キーがすでに存在していた場合は人間がキーボードを入力するまで何も行わない
if [ ! -e $HOME/.ssh/id_rsa ] then;
    ssh-keygen -t rsa -N "" -f ~/.ssh/id_rsa
fi
