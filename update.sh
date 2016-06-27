#!/bin/bash

echo "=> Upcloning git repos"

function upclone {
    if [ -d ${2} ]; then
        echo "=> Directory ${2} exists, updating."
        cd ${2} && git pull
    else
        echo "=> Directory ${2} does not exist, cloning."
        git clone ${1} ${2}
    fi
}

upclone https://github.com/VundleVim/Vundle.vim ~/.vim/bundle/Vundle.vim
upclone https://github.com/chriskempson/base16-shell ~/.config/base16-shell
upclone https://github.com/robbyrussell/oh-my-zsh ~/.oh-my-zsh
upclone https://github.com/mozilla/rust ~/.rust

cd ~/.dotfiles

echo "=> Running VundleInstall"
vim +PluginInstall +qall

echo "=> Updating YouCompleteMe"
lastfile=".ycmlast"
ycmlast=`[ -e ${lastfile} ] && cat ${lastfile}`
git --git-dir=dots/.vim/bundle/YouCompleteMe/.git rev-list --max-count=1 HEAD > ${lastfile}
ycmhead=`cat ${lastfile}`

if [[ ${ycmhead} == ${ycmlast} ]]; then
    echo "    YouCompleteMe should still be up to date, not compiling!"
    echo "    To compile again manually:"
    echo "        cd ~/.vim/bundle/YouCompleteMe/ && ./install.py --all"
else
    cd ~/.vim/bundle/YouCompleteMe/ && ./install.py --all
fi
