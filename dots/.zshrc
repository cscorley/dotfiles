ZSH=$HOME/.oh-my-zsh
ZSH_THEME="mortalscumbag-light"
DISABLE_AUTO_UPDATE="true"
COMPLETION_WAITING_DOTS="true"
plugins=(git svn mercurial python zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

HISTSIZE=20000
SAVEHIST=20000

setopt append_history
setopt extended_history
setopt hist_verify
setopt inc_append_history

# do not record commands that begin with space
setopt hist_ignore_space
# do not complain when a pattern fails
setopt null_glob

setopt nocorrectall
setopt correct

# update index before every attempt to autocomplete
zstyle ":completion:*:commands" rehash 1

#csc customs
alias weather='cursetheweather --nometric 35401'
alias openscreen='screen -U -D -R'
alias dirc='dtach -A /tmp/csc-irssi.socket irssi'
alias dtorrent='dtach -A /tmp/csc-rtorrent.socket rtorrent'
alias ffcastpulse='ffcast_filename=`date +ffcast-%Y%m%d-%H%M%S.mkv`; ffcast -s ffmpeg -f alsa -i pulse -vcodec libx264 ${ffcast_filename}'

alias open='xdg-open'
alias vi='vim'
alias c='clear'

# safety copy, delete & colour
alias rm='rm -i'
alias cp='cp -iv'
alias mv='mv -i'
alias ll='ls -lhav'
alias ls='ls -v --color=auto'
alias df='df -h'
alias du='du -hc'
alias mv='mv -iv'
alias cp='cp -v'

pacsyu (){
    sudo pacman -Syu
}

# coloured pacman output
alias pacs="pacsearch"
pacsearch () {
       echo -e "$(pacman -Ss $@ | sed \
       -e 's#current/.*#\\033[1;31m&\\033[0;37m#g' \
       -e 's#extra/.*#\\033[0;32m&\\033[0;37m#g' \
       -e 's#community/.*#\\033[1;35m&\\033[0;37m#g' \
       -e 's#^.*/.* [0-9].*#\\033[0;36m&\\033[0;37m#g' )"
}

#dirsize - finds directory sizes and lists them for the current directory
dirsize ()
{
du -shx * .[a-zA-Z0-9_]* 2> /dev/null | \
egrep '^ *[0-9.]*[MGK]' | sort -n > /tmp/list
egrep '^ *[0-9.]*K' /tmp/list
egrep '^ *[0-9.]*M' /tmp/list
egrep '^ *[0-9.]*G' /tmp/list
rm -rf /tmp/list
}

#bu - Back Up a file. Usage "bu filename.txt"
bu () { cp $1 ${1}-`date +%Y%m%d%H%M`.backup ; }

extract () {
    if [ -f $1 ] ; then
        case $1 in
            *.tar.bz2)  tar xjf $1      ;;
            *.tar.gz)   tar xzf $1      ;;
            *.bz2)      bunzip2 $1      ;;
            *.rar)      unrar x $1      ;;
            *.gz)       gunzip $1       ;;
            *.tar)      tar xf $1       ;;
            *.tbz2)     tar xjf $1      ;;
            *.tbz)     tar xjf $1      ;;
            *.tgz)      tar xzf $1      ;;
            *.zip)      unzip $1        ;;
            *.Z)        uncompress $1   ;;
            *)          echo "'$1' cannot be extracted via extract()" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}


# special keys
# source: https://wiki.archlinux.org/index.php/Zsh
#
bindkey "\e[1~" beginning-of-line # Home
bindkey "\e[4~" end-of-line # End
bindkey "\e[5~" beginning-of-history # PageUp
bindkey "\e[6~" end-of-history # PageDown
bindkey "\e[2~" quoted-insert # Ins
bindkey "\e[3~" delete-char # Del
bindkey "\e[5C" forward-word
bindkey "\eOc" emacs-forward-word
bindkey "\e[5D" backward-word
bindkey "\eOd" emacs-backward-word
bindkey "\e\e[C" forward-word
bindkey "\e\e[D" backward-word
bindkey "\e[Z" reverse-menu-complete # Shift+Tab
# for rxvt
bindkey "\e[7~" beginning-of-line # Home
bindkey "\e[8~" end-of-line # End
# for non RH/Debian xterm, can't hurt for RH/Debian xterm
bindkey "\eOH" beginning-of-line
bindkey "\eOF" end-of-line
# for freebsd console
bindkey "\e[H" beginning-of-line
bindkey "\e[F" end-of-line
