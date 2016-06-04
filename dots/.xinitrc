#!/bin/sh

[ -f /etc/xprofile ] && . /etc/xprofile
[ -f ~/.xprofile ] && . ~/.xprofile

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

xrdb -merge ~/.Xresources

case $1 in
    awesome)
        exec awesome
        ;;
    twm)
        twm &
        xclock -geometry 50x50-1+1 &
        xterm -geometry 80x50+494+51 &
        xterm -geometry 80x20+494-0 &
        exec xterm -geometry 80x66+0+0 -name login
        ;;
    xmonad)
        exec xmonad
        ;;
    wtftw)
        exec wtftw
        ;;
    *)
        exec awesome
        ;;
esac

