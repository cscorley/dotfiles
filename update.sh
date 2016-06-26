#!/bin/bash

echo "=> Updating git repos"

cd ~/.vim/bundle/Vundle.vim && git pull 
cd ~/.config/base16-shell && git pull
cd ~/.oh-my-zsh && git pull
cd ~/.rust && git pull


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
