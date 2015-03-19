#!/usr/bin/env bash

function symlink {
  GLOB=$1
  DEST="$2"
  CWD=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
  for f in $GLOB; do
    ln -sfv "$CWD/$f" "$DEST/$f"
  done
}

# Zsh settings
symlink '.z*' $HOME

# Git settings
symlink '.gitconfig' $HOME

# SSH settings
test -d $HOME/.ssh || ssh-keygen
symlink '.ssh/*' $HOME

# Ruby settings
symlink '.gemrc' $HOME

# Sublime settings
symlink '*.sublime-settings' "$HOME/Library/Application Support/Sublime Text 3/Packages/User"

# Miscellaneous scripts
symlink 'bin/*' /usr/local
hash -r

# Show hidden files in Finder
defaults write com.apple.finder AppleShowAllFiles YES
