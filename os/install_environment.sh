#!/usr/bin/env bash

source $(dirname $0)/.bash_personal_commands

echo "Get sudo user"
sudo -l

if [ $os_system == "Darwin" ]; then
    if ! command_exists brew; then
        echo "Installing homebrew"
        /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    fi
fi

if [ $os_system == "Linux" ]; then
    if ! command_exists curl; then
        echo "Installing curl"
        sudo apt -y install curl
    fi
fi

function install_basic_package {
    if ! command_exists $1 && ! package_exists $1; then
        echo "Installing $1"

        case $os_system in
            "Linux" ) sudo apt -y install $1 || (echo "installation of $1 failed" ; exit 1) ;;
            "Darwin" ) brew install $1 || (echo "installation of $1 failed" ; exit 1) ;;
            * ) echo "You are doomed"; exit 1 ;;
        esac
    else
        emojify "Your system already has $1 :kissing_smiling_eyes:"
        echo "xxxxxxxxxxxxxxxxxxxxxxx"
    fi
}


function install_basic_package_with_npm {
    if ! command_exists $1; then
        echo "Installing $1"
        sudo npm install -g $1 || (echo "installation of $1 failed" ; exit 1)
    else
        emojify "Your system already has $1 :kissing_smiling_eyes:"
        echo "xxxxxxxxxxxxxxxxxxxxxxx"
    fi
}

if ! command_exists emojify; then
    echo "Install emojify"
    sudo sh -c "curl https://raw.githubusercontent.com/mrowa44/emojify/master/emojify -o /usr/local/bin/emojify && chmod +x /usr/local/bin/emojify"
fi

emojify "Let's start hoarding stuff :smile:"

#----------------------------------------------------------------------------

if [ $os_system == "Darwin" ]; then
    brew install llvm
fi

sudo apt-get update

install_basic_package python-dev
install_basic_package python3-dev

curl "https://bootstrap.pypa.io/get-pip.py" -o "get-pip.py"

if ! command_exists pip; then
    python get-pip.py --user || (echo "installation of $1 failed" ; exit 1)
    source ~/.bashrc
fi

if ! command_exists pip3; then
    python3 get-pip.py --user || (echo "installation of $1 failed" ; exit 1)
    source ~/.bashrc
fi

rm -rf get-pip.py

function install_basic_package_with_pip {
    if ! command_exists $1 && ! pip_package_exists $1; then
        echo "Installing $1"
        pip install $1 --user || (echo "installation of $1 failed" ; exit 1)
    else
        emojify "Your sytem already has $1 :kissing_smiling_eyes:"
        echo "xxxxxxxxxxxxxxxxxxxxxxx"
    fi
}

function install_basic_package_with_pip3 {
    if ! command_exists $1 && ! pip3_package_exists $1; then
        echo "Installing $1"
        pip3 install $1 --user
    else
        emojify "Your sytem already has $1 :kissing_smiling_eyes:"
        echo "xxxxxxxxxxxxxxxxxxxxxxx"
    fi
}

#----------------------------------------------------------------------------

install_basic_package silversearcher-ag
install_basic_package xclip
install_basic_package markdown
install_basic_package thefuck
install_basic_package terminator
install_basic_package htop
install_basic_package screenfetch
install_basic_package tree
install_basic_package tmux
install_basic_package cmake
install_basic_package bpython
install_basic_package bpython3
install_basic_package clang-format

echo "###quick fix to install pylint"
# pip install configparser==3.3.0.post2
install_basic_package pylint
# install gtags
install_basic_package global
install_basic_package tig
install_basic_package xclip
install_basic_package graphviz
install_basic_package npm #package manager for javascript

#----------------------------------------------------------------------------

install_basic_package_with_pip cpplint
install_basic_package_with_pip jupyter
install_basic_package_with_pip requests
install_basic_package_with_pip jedi
install_basic_package_with_pip flake8
install_basic_package_with_pip autopep8
install_basic_package_with_pip ranger-fm

#----------------------------------------------------------------------------

emojify "install miscellaneous :kissing_smile_eyes:"

# terminator customization
echo "terminator customization"
if [ -d $HOME/.config/terminator/plugins ]; then
    mkdir -p $HOME/.config/terminator/plugins
    wget https://git.io/v5Zww -O $HOME/.config/terminator/plugins/terminator-themes.py
    # python $HOME/.config/terminator/plugins/terminator-themes.py
fi

#----------------------------------------------------------------------------

if ! command_exists nodejs; then
    curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -
    sudo apt -y install nodejs
    sudo npm install npm@latest -g
fi

install_basic_package_with_npm diff-so-fancy

# install cask for emacs
curl -fsSL https://raw.githubusercontent.com/cask/cask/master/go | python

# install conda
bash install_conda.sh
