#!/bin/sh
#xbindkeys
start-pulseaudio-x11 &
mpd ~/.mpd/mpd.conf &
mpc stop &

pidof mpdscribble >& /dev/null
if [ $? -ne 0 ]; then
     mpdscribble --conf ~/.mpdscribble/mpdscribble.conf &
fi

dropboxd &
gtk-redshift &

if [[ -e ~/.fehbg ]] ; then
    sh ~/.fehbg
fi

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

#twm)
#	twm &
#	xclock -geometry 50x50-1+1 &
#	xterm -geometry 80x50+494+51 &
#	xterm -geometry 80x20+494-0 &
#	exec xterm -geometry 80x66+0+0 -name login
#	;;
#esac


