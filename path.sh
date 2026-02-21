#!/bin/bash
. "$HOME/.cargo/env"
export GHCUP_INSTALL_BASE_PREFIX="${GHCUP_INSTALL_BASE_PREFIX:-$HOME}"
export PATH="$HOME/.cabal/bin:$PATH:/home/dmytro/.ghcup/bin"
