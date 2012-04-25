# make bash launch zsh if it exists.
#
# works great when you can't use chsh because the sysadmin says it's "a security risk" ಠ_ಠ

binary=$(which zsh)

if [ $? -eq 0 ]; then
    exec zsh
fi
