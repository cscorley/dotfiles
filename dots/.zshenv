# Customize to your needs...
export PATH="${HOME}/bin/:${HOME}/.cabal/bin:$(ruby -rubygems -e "puts Gem.user_dir")/bin::${PATH}"
export SDL_AUDIODRIVER='pulse'
# URxvt has screwed up for the last time.)
export TERMINAL=$(which lilyterm)
export EDITOR=$(which vim)
export BROWSER=$(which chromium)

export GREP_OPTIONS='--color=auto'
export PYTHONDONTWRITEBYTECODE=true
export CHROMIUM_USER_FLAGS="--ppapi-flash-path=/usr/lib/PepperFlash/libpepflashplayer.so --ppapi-flash-version=11.3.31.103"
