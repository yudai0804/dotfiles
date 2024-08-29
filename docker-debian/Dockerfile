FROM debian:12

ENV HOME /root

RUN apt-get update && apt-get install -y sudo git curl
WORKDIR $HOME/dotfiles
COPY . .
RUN chmod +x scripts/install.sh
RUN ./scripts/install.sh
WORKDIR $HOME