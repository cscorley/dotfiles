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

ycmdir="${HOME}/.vim/bundle/YouCompleteMe"
upclone https://github.com/Valloric/YouCompleteMe ${ycmdir}
upclone https://github.com/VundleVim/Vundle.vim ${HOME}/.vim/bundle/Vundle.vim
upclone https://github.com/chriskempson/base16-shell ${HOME}/.config/base16-shell
upclone https://github.com/robbyrussell/oh-my-zsh ${HOME}/.oh-my-zsh
upclone https://github.com/mozilla/rust ${HOME}/.rust

cd ${HOME}/.dotfiles

echo "=> Running VundleInstall"
vim +PluginInstall +qall

echo "=> Updating YouCompleteMe"
lastfile="${PWD}/.ycmlast"
ycmlast=`[ -e ${lastfile} ] && cat ${lastfile}`
git --git-dir=${ycmdir}/.git rev-list --max-count=1 HEAD > ${lastfile}
ycmhead=`cat ${lastfile}`

if [[ "${ycmhead}" == "${ycmlast}" ]]; then
    echo "    YouCompleteMe should still be up to date, not compiling!"
    echo "    To compile again manually:"
    echo "        cd ${HOME}/.vim/bundle/YouCompleteMe/ && ./install.py --all"
else
    cd ${HOME}/.vim/bundle/YouCompleteMe/ && ./install.py --all
fi
