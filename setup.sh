#!/bin/bash
#set -e

function symlink_interactive(){
    for file in `ls -A ${PWD}/dots`; do
        if [[ -d ${HOME}/${file} ]] ; then
            if [[ -L ${HOME}/${file} ]] ; then
                rm -i ${HOME}/${file}
            else
                mv -i ${HOME}/${file} ${HOME}/${file}.backup
            fi

            if [[ ! -e ${HOME}/${file} ]] ; then
                ln -si "${PWD}/dots/${file}" ${HOME}/${file}
            fi
        else
            ln -si "${PWD}/dots/${file}" ${HOME}/${file}
        fi
    done
}

echo "-----> SETUP! --------------------------------------------------"
echo "----->        This will interactively setup files from dots into ${HOME}."
echo "----->        To skip interactivity, pipe 'yes' into this setup."
echo "-----> SETUP! --------------------------------------------------"
echo ""

os=`uname -o`
echo "!> Found OS: ${os}"

if [ -d ${HOME}/.dotfiles ]; then
    echo "!> A '${HOME}/.dotfiles' directory already exists. Not cloning repo."
    echo "!> Please remove and re-run if necessary."
else
    echo "-> Cloning main dotfile repo..."
    git clone https://github.com/cscorley/dotfiles.git ${HOME}/.dotfiles
fi

echo "-> Installing..."
cd ${HOME}/.dotfiles

if [ "${os}" == "Cygwin" ]; then
    echo "-> Interactively copying dotfiles instead of symlinking..."
    cp -ivR dots/.* ${HOME}
else
    echo "-> Interactively symlinking dotfiles..."
    symlink_interactive
fi

mkdir -p ${HOME}/.vim/tmp/{backup,swap,undo}

echo "-> Running update script to clone git repos and install Vundle plugins"

./update.sh

echo "-> Copying files from 'manual' directory"
cp manual/mortaldouchebag.zsh-theme ${HOME}/.oh-my-zsh/themes/

if [ "${os}" == "Linux" ]; then
    echo "-> Installing powerline font"
    mkdir -p ${HOME}/.fonts/
    cd ${HOME}/.fonts
    curl -O https://github.com/Lokaltog/powerline/raw/develop/font/PowerlineSymbols.otf

    fc-cache -vf ${HOME}/.fonts/
fi

echo "-> Done."
