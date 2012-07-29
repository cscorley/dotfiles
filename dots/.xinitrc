#!/bin/sh

[ -f /etc/xprofile ] && . /etc/xprofile
[ -f ~/.xprofile ] && . ~/.xprofile

case $1 in
    openbox)
        exec openbox-session 
        ;;
    awesome)
        exec awesome 
        ;;
    lxde)
        exec ck-launch-session startlxde 
        ;;
    awesomecfg)
        exec awesome -c $2
        ;;
    *)
        exec awesome
        ;;
esac

