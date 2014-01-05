#!/bin/sh

[ -f ~/.profileutil ] && . ~/.profileutil

runif Linux eval $(runif Linux /usr/bin/keychain --eval --agents ssh -Q -q id_rsa)


