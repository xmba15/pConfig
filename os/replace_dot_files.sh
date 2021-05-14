#!/usr/bin/env bash

# Note: this script should be executed inside the directory that holds it
parent_dir=$(cd `pwd`/.. && pwd)
echo $parent_dir

echo "backup current setting"

# -h FILE true if file exists and is a symbolic link

# set symbolic link for the whole directory
# arg: [name of the directory] [name of the symbolic link]
function set_symbolic_link_for_dir {
    if [ $# -ne 2 ]; then
        echo "Usage: set_symbolic_link_for_dir [dir name] [alias dir name]"
        exit 1
    fi
    echo "set symbolic link for $1"
    if [ -d $HOME/$2 ]; then
        if [ -h $HOME/$2 ]; then
            rm -rf $HOME/$2
        else
            mv $HOME/$2 $HOME/$2_backup
        fi
    fi
    ln -s $parent_dir/$1 $HOME/$2
}

function set_symbolic_link {
    echo "set symbolic link for $1"
    if [ -f $HOME/$1 ]; then
        if [ -h $HOME/$1 ]; then
            rm -rf $HOME/$1
        else
            mv $HOME/$1 $HOME/$1_backup
        fi
    fi
    ln -s $parent_dir/$2/$1 $HOME/
}

function set_symbolic_link_no_dir_struct {
    echo "set symblic link for $1"
    if [ -f $HOME/$2/$1 ]; then
        if [ -h $HOME/$2/$1 ]; then
            rm -rf  $HOME/$2/$1
        else
            mv $HOME/$2/$1 $HOME/$2/$1_backup
        fi
    fi
    ln -s $parent_dir/$1 $HOME/$2/$1
}

set_symbolic_link .tmux.conf tmux
set_symbolic_link .bashrc os
set_symbolic_link .bash_personal_commands os
set_symbolic_link .bash_config os
set_symbolic_link .bash_ros os
set_symbolic_link .pythonrc os

echo "###specific prepation for emacs"
if [ ! -L $HOME/.emacs.d ]; then
    if [ -d $HOME/.emacs.d ]; then
        mv $HOME/.emacs.d $HOME/.emacs.d.backup
    else
        set_symbolic_link .emacs.d emacs
    fi
fi
set_symbolic_link_no_dir_struct gtk-3.0/gtk.css .config

echo "###specific prepation for terminator config"
if [ ! -d $HOME/.config/terminator ]; then
    mkdir $HOME/.config/terminator
fi

set_symbolic_link_no_dir_struct terminator/config .config

set_symbolic_link_for_dir personal_templates .personal_templates
