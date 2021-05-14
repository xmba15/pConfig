#!/usr/bin/env bash

echo "install dependencies"

sudo apt-get install -y make build-essential libssl-dev zlib1g-dev libbz2-dev \
libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev libncursesw5-dev \
xz-utils tk-dev libffi-dev liblzma-dev python-openssl git

CONFIGURE_OPTS=--enable-shared pyenv install 2.7.15
CONFIGURE_OPTS=--enable-shared pyenv install 3.6.6
