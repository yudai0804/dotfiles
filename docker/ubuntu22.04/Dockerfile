FROM ubuntu:22.04

# Set the timezone to Asia/Tokyo
RUN apt-get update
# 必要最低限のコマンドをインストール
RUN apt-get install -y tzdata
RUN ln -sf /usr/share/zoneinfo/Asia/Tokyo /etc/localtime
# tzdataをinstallしたあとにgitをインストールしないとビルドが成功しないので注意
RUN apt-get install -y sudo
RUN apt-get install -y git
RUN apt-get install -y curl
