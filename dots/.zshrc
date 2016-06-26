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

# Base16 Shell
export BASE16_SCHEME="summerfruit"
export BASE16_SHADE="light"
BASE16_SHELL="$HOME/.config/base16/output/shell/base16-$BASE16_SCHEME.$BASE16_SHADE.sh"
[[ -s $BASE16_SHELL ]] && . $BASE16_SHELL

typeset -U path
path=(
    ~/bin
    ~/.cabal/bin
    ~/.cargo/bin
    $(ruby -rubygems -e "puts Gem.user_dir")/bin
    /usr/local/bin
    ${JAVA_HOME}/bin
    /opt/java/bin
    /usr/local/texlive/2013/bin/x86_64-darwin
    $path
    )

export RUST_SRC_PATH="${HOME}/.rust/src"
export SDL_AUDIODRIVER='pulse'

export TERMINAL=$(which roxterm)
export ALTERNATE_EDITOR=$(which vim)
export EDITOR=$(which vim)
export VISUAL=$(which gvim)
export BROWSER=$(which firefox)

export SHELL="/bin/zsh"
export ESHELL="/bin/zsh"

if [[ ${TERM} == "xterm" ]]; then
    export TERM=xterm-256color
fi

# virtual envvvvvvvvvvvvv
export WORKON_HOME="${HOME}/envs/"
export PROJECT_HOME="${HOME}/git/"
source $(which virtualenvwrapper.sh)

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


export BLOG_DIR="${HOME}/git/christop.club"


nbconvert(){
    ipython nbconvert --config jekyll.py $@
    find ${BLOG_DIR}/notebooks/ -name '*.md' -exec mv {} ${BLOG_DIR}/_drafts/ \;
    cp $@ ${BLOG_DIR}/notebooks/
}



alias openscreen='screen -U -D -R'
alias dirc='tmux new-session -A -s irc weechat'
alias dtorrent='tmux new-session -A -s torrent rtorrent'
alias beep='paplay /usr/share/sounds/freedesktop/stereo/complete.oga'
alias addon-sdk="cd /opt/addon-sdk && source bin/activate; cd -"
alias pdflatex="pdflatex -halt-on-error"


# alias sup='chruby ruby-1.9.3 && sup'

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
alias grep='grep --color=auto'
alias which='which -a'

runifos Linux alias open='xdg-open'
runifos Linux alias ls='ls -v --color=auto'
runifos Darwin alias ls='ls -vG' # --color=auto'
runifos Darwin alias sha1sum='shasum'

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
            *.tbz)      tar xjf $1      ;;
            *.tgz)      tar xzf $1      ;;
            *.zip)      unzip $1        ;;
            *.Z)        uncompress $1   ;;
            *.7z)       7z x $1         ;;
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

[[ -n "${TMUX}" ]] && bindkey '\e[1~' beginning-of-line
[[ -n "${TMUX}" ]] && bindkey '\e[4~' end-of-line
