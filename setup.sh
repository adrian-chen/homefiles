#!/usr/bin/env bash

set -eu

CWD=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

function symlink {
  GLOB=$1
  DEST="$2"
  for f in $GLOB; do
    ln -sfv $CWD/$f "$DEST/$f"
  done
}

# Zsh dotfiles
symlink '.z*' $HOME

# Git settings
symlink '.gitconfig' $HOME

# SSH settings
symlink '.ssh/*' $HOME

# Ruby settings
symlink '.gemrc' $HOME

# Sublime settings
symlink '*.sublime-settings' "$HOME/Library/Application Support/Sublime Text 3/Packages/User"

# Miscellaneous scripts
symlink 'bin/*' /usr/local
hash -r
