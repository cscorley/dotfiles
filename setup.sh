#!/bin/bash
set -e

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
    echo "A ~/.dotfiles directory already exists. Aborting."
    exit
fi

if [ -e ~/.githubtoken ]; then
    echo "Using ~/.githubtoken as .gitconfig's github.token value. Be sure your token actually exists there."
else
    echo "Please put your github.token into ~/.githubtoken"
    touch ~/.githubtoken
fi

echo "Cloning repo..."
/usr/bin/env git clone https://github.com/cscorley/dotfiles.git ~/.dotfiles

echo "Installing..."
cd ~/.dotfiles

if [ "${1}" == "-f" ]; then
    symlink_force
else
    symlink_interactive
fi

make install

echo "Done."
