#!/bin/bash
#set -e

# I haven't tested any of these functions. No fucks given.
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
                echo "Moving ~/${file} to ~/${file}.backup"
                mv -f ~/${file} ~/${file}.backup
            fi
        fi
        ln -sf "${PWD}/dots/${file}" ~/${file}
    done
}

if [ -d ~/.dotfiles ]; then
    echo "A ~/.dotfiles directory already exists. Not cloning repo."
    echo ">>> Please remove and re-run if necessary."
else
    echo "Cloning repo..."
    /usr/bin/env git clone https://github.com/cscorley/dotfiles.git ~/.dotfiles
fi

echo "Installing..."

cd ~/.dotfiles

if [ "${1}" == "-f" ]; then
    echo "Forcing symlink creation. Godspeed, brother!"
    symlink_force
else
    echo "Interactively symlinking ~/.dotfiles..."
    symlink_interactive
fi

mkdir -p ~/.vim/tmp/{backup,swap,undo}

echo "Setting up subrepos..."
make install

echo "Copying files in manual"
cp manual/mortaldouchebag.zsh_theme ~/.oh-my-zsh/themes/

echo "Done."
