#!/usr/bin/env bash

function command_exists {
    type "$1" &> /dev/null ;
}

sudo -l

sudo apt-get install texinfo libxpm-dev libjpeg-dev libgif-dev libtiff-dev libgnutls28-dev

if ! command_exists emacs26; then
    echo "Install emacs 26"
    cd $HOME/publicWorkspace/packages/
    git clone -b emacs-26 https://github.com/emacs-mirror/emacs.git
    cd emacs
    sudo ./autogen.sh
    sudo ./configure --with-x-toolkit=no
    sudo make -j4
    sudo make install
    echo "Finished installing emacs 26"
fi
