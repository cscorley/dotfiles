#!/bin/bash
#set -e

symlink_interactive () {
    for file in `ls -A`; do
        if [ -d ${HOME}/${file} ] ; then
            if [ -L ${HOME}/${file} ] ; then
                rm -i ${HOME}/${file}
            else
                mv -i ${HOME}/${file} ${HOME}/${file}.backup
            fi

            if [ ! -e ${HOME}/${file} ] ; then
                ln -si "${PWD}/${file}" ${HOME}/${file}
            fi
        else
            ln -si "${PWD}/${file}" ${HOME}/${file}
        fi
    done
}

copy_cpio (){
    echo "Press the any key to begin."
    read okay
    find . | cpio --unconditional --link --pass-through --verbose --make-directories --preserve-modification-time ${HOME}
}

echo "-----> SETUP! --------------------------------------------------"
echo "----->        This will interactively setup files from dots into ${HOME}."
echo "----->        To skip interactivity, pipe 'yes' into this setup."
echo "-----> SETUP! --------------------------------------------------"
echo ""

os=`uname -s`
echo "!> Found OS: ${os}"

if [ -d ${HOME}/.dotfiles ]; then
    echo "!> A '${HOME}/.dotfiles' directory already exists. Not cloning repo."
    echo "!> Please remove and re-run if necessary."
    echo "-> Updating git"
    cd ${HOME}/.dotfiles;
    git pull
else
    echo "-> Cloning main dotfile repo..."
    git clone https://github.com/cscorley/dotfiles.git ${HOME}/.dotfiles
fi

echo "-> Installing..."
cd ${HOME}/.dotfiles/dots/

if [ "${os}" == "Cygwin" ] || [ "${os}" == "CYGWIN_NT-10.0" ]; then
    echo "-> Copying dotfiles instead of symlinking..."
    copy_cpio
else
    echo "-> Interactively symlinking dotfiles..."
    symlink_interactive
fi

mkdir -p ${HOME}/.vim/tmp/{backup,swap,undo}

echo "-> Running update script to clone git repos and install Vundle plugins"

${HOME}/.dotfiles/update.sh || true

echo "-> Copying files from 'manual' directory"
cp -v ${HOME}/.dotfiles/manual/mortaldouchebag.zsh-theme ${HOME}/.oh-my-zsh/themes/
cp -v ${HOME}/.dotfiles/manual/base16-summerfruit-*.vim ${HOME}/.vim/bundle/base16-vim/colors/
cp -v ${HOME}/.dotfiles/manual/base16-summerfruit-*.sh ${HOME}/.config/base16-shell/scripts/

if [ "${os}" == "Linux" ] || [ "${os}" == "GNU/Linux" ]; then
    echo "-> Installing powerline font"
    mkdir -p ${HOME}/.fonts/
    cd ${HOME}/.fonts
    curl -O https://github.com/Lokaltog/powerline/raw/develop/font/PowerlineSymbols.otf

    fc-cache -vf ${HOME}/.fonts/
fi

echo "-> Done."
echo "!> To update in the future, run './update.sh'"
