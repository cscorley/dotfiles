if [ -d ~/.dotfiles ]
then
    echo "A ~/.dotfiles directory already exists. Aborting."
    exit
fi

echo "Cloning repo..."
/usr/bin/env git clone https://github.com/cscorley/dotfiles.git ~/.dotfiles


echo "Installing..."
cd ~/.dotfiles
make install

echo "Done."
