#!/bin/bash

if [[ -e ~/.fehbg ]] ; then
    sh ~/.fehbg
fi

start-pulseaudio-x11 &

pidof mpd >& /dev/null
if [ $? -ne 0 ]; then
    mpd ~/.mpd/mpd.conf
    mpc stop &
fi

pidof mpdscribble >& /dev/null
if [ $? -ne 0 ]; then
     mpdscribble --conf ~/.mpdscribble/mpdscribble.conf &
fi

dropboxd &
gtk-redshift &
clipit &
xmodmap ~/.xmodmaprc &
#xbindkeys
xset m 0 0 &

xrdb -merge ~/.Xresources
