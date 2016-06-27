#!/bin/bash
#set -e

function symlink_interactive(){
    for file in `ls -A ${PWD}/dots`; do
        if [[ -d ~/${file} ]] ; then
            if [[ -L ~/${file} ]] ; then
                rm -i ~/${file}
            else
                mv -i ~/${file} ~/${file}.backup
            fi

            if [[ ! -e ~/${file} ]] ; then
                ln -si "${PWD}/dots/${file}" ~/${file}
            fi
        else
            ln -si "${PWD}/dots/${file}" ~/${file}
        fi
    done
}

function symlink_force(){
    for file in `ls -A ${PWD}/dots`; do
        if [[ -d ~/${file} ]] ; then
            if [[ ! -L ~/${file} ]]; then
                echo "-> Moving ~/${file} to ~/${file}.backup"
                mv -f ~/${file} ~/${file}.backup
            fi
        fi
        ln -sf "${PWD}/dots/${file}" ~/${file}
    done
}

if [ -d ~/.dotfiles ]; then
    echo "!> A ~/.dotfiles directory already exists. Not cloning repo."
    echo "!> Please remove and re-run if necessary."
else
    echo "-> Cloning main dotfile repo..."
    git clone https://github.com/cscorley/dotfiles.git ~/.dotfiles
fi

echo "-> Installing..."
cd ~/.dotfiles

if [ "${1}" == "-f" ]; then
    echo "-> Forcing symlink creation. Godspeed!"
    symlink_force
else
    echo "-> Interactively symlinking ~/.dotfiles..."
    symlink_interactive
fi

mkdir -p ~/.vim/tmp/{backup,swap,undo}

echo "-> Running update script to clone git repos and install Vundle plugins"

./update.sh

echo "-> Copying files from 'manual' directory"
cp manual/mortaldouchebag.zsh-theme ~/.oh-my-zsh/themes/

echo "-> Installing powerline font"
mkdir -p ~/.fonts/
cd ~/.fonts
curl -O https://github.com/Lokaltog/powerline/raw/develop/font/PowerlineSymbols.otf
fc-cache -vf ~/.fonts/

echo "-> Done."
