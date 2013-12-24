#!/bin/sh

[ -f ~/.profileutil ] && . ~/.profileutil

runif Linux eval "/usr/bin/keychain --eval --agents ssh -Q -q id_rsa &"


