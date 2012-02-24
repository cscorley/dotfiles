#!/bin/bash

if [ -d ~/.dotfiles ]
then
    echo "A ~/.dotfiles directory already exists. Aborting."
    exit
fi

if [ -e ~/.githubtoken ]
then
    echo "Using ~/.githubtoken as .gitconfig's github.token value. Be sure your token actually exists there."
elif
    echo "Please put your github.token into ~/.githubtoken"
    touch ~/.githubtoken
fi

echo "Cloning repo..."
/usr/bin/env git clone https://github.com/cscorley/dotfiles.git ~/.dotfiles


echo "Installing..."
cd ~/.dotfiles
make install

echo "Done."
