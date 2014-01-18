[ -f ~/.profileutil ] && . ~/.profileutil

ZSH=$HOME/.oh-my-zsh
ZSH_THEME="mortaldouchebag"
DISABLE_AUTO_UPDATE="true"
COMPLETION_WAITING_DOTS="true"
plugins=(
    git git-extras svn mercurial
    python pip
    brew
    zsh-syntax-highlighting
)


typeset -U path
path=(~/bin ~/.cabal/bin $(ruby -rubygems -e "puts Gem.user_dir")/bin /usr/local/bin $path)
export SDL_AUDIODRIVER='pulse'
export TERMINAL=$(which gnome-terminal)
export EDITOR=$(which vim)
export BROWSER=$(which firefox)

if [[ ${TERM} == "xterm" ]]; then
    export TERM=xterm-256color
fi

export GREP_OPTIONS='--color=auto'
#export PYTHONDONTWRITEBYTECODE=true

#eval "$(rbenv init -)"

source $ZSH/oh-my-zsh.sh
source $HOME/.autoenv/activate.sh
if [ -f /usr/local/opt/chruby/share/chruby/chruby.sh ]; then
    source /usr/local/opt/chruby/share/chruby/chruby.sh
    source /usr/local/opt/chruby/share/chruby/auto.sh
elif [ -f /usr/share/chruby/chruby.sh ]; then
    source /usr/share/chruby/chruby.sh
    source /usr/share/chruby/auto.sh
fi

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

alias openscreen='screen -U -D -R'
alias dirc='dtach -A /tmp/csc-irssi.socket irssi'
alias dtorrent='dtach -A /tmp/csc-rtorrent.socket rtorrent'
alias ffcastpulse='ffcast_filename=`date +ffcast-%Y%m%d-%H%M%S.mkv`; ffcast -s ffmpeg -f alsa -i pulse -vcodec libx264 ${ffcast_filename}'
alias winboot='sudo grub-reboot 2 && sudo reboot'

alias sup='chruby ruby-1.9.3 && sup'

alias vi='vim'
alias c='clear'
alias l='ll'

# safety copy, delete & colour
alias rm='rm -i'
alias cp='cp -iv'
alias mv='mv -i'
alias ll='ls -lhav'
alias df='df -h'
alias du='du -hc'
alias mv='mv -iv'
alias cp='cp -v'
alias which='which -a'

runif Linux alias open='xdg-open'
runif Linux alias ls='ls -v --color=auto'
runif Darwin alias ls='ls -vG' # --color=auto'

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
# create a zkbd compatible hash;
# to add other keys to this hash, see: man 5 terminfo
typeset -A key

key[Home]=${terminfo[khome]}

key[End]=${terminfo[kend]}
key[Insert]=${terminfo[kich1]}
key[Delete]=${terminfo[kdch1]}
key[Up]=${terminfo[kcuu1]}
key[Down]=${terminfo[kcud1]}
key[Left]=${terminfo[kcub1]}
key[Right]=${terminfo[kcuf1]}
key[PageUp]=${terminfo[kpp]}
key[PageDown]=${terminfo[knp]}

# setup key accordingly
[[ -n "${key[Home]}"     ]]  && bindkey  "${key[Home]}"     beginning-of-line
[[ -n "${key[End]}"      ]]  && bindkey  "${key[End]}"      end-of-line
[[ -n "${key[Insert]}"   ]]  && bindkey  "${key[Insert]}"   overwrite-mode
[[ -n "${key[Delete]}"   ]]  && bindkey  "${key[Delete]}"   delete-char
[[ -n "${key[Up]}"       ]]  && bindkey  "${key[Up]}"       up-line-or-history
[[ -n "${key[Down]}"     ]]  && bindkey  "${key[Down]}"     down-line-or-history
[[ -n "${key[Left]}"     ]]  && bindkey  "${key[Left]}"     backward-char
[[ -n "${key[Right]}"    ]]  && bindkey  "${key[Right]}"    forward-char
#[[ -n "${key[PageUp]}"   ]]  && bindkey  "${key[PageUp]}"   beginning-of-buffer-or-history
#[[ -n "${key[PageDown]}" ]]  && bindkey  "${key[PageDown]}" end-of-buffer-or-history

[[ -n "${key[PageUp]}"   ]]  && bindkey  "${key[PageUp]}"    history-beginning-search-backward
[[ -n "${key[PageDown]}" ]]  && bindkey  "${key[PageDown]}"  history-beginning-search-forward

# Finally, make sure the terminal is in application mode, when zle is
# active. Only then are the values from $terminfo valid.
if (( ${+terminfo[smkx]} )) && (( ${+terminfo[rmkx]} )); then
    function zle-line-init () {
        printf '%s' "${terminfo[smkx]}"
    }
    function zle-line-finish () {
        printf '%s' "${terminfo[rmkx]}"
    }
    zle -N zle-line-init
    zle -N zle-line-finish
fi

