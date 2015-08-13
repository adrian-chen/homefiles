#!/usr/bin/env bash

set -eu

function symlink {
  GLOB=$1
  DEST=$2
  CWD=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
  for f in $GLOB; do
    ln -sfv "$CWD/$f" "$DEST/$f"
  done
}

# Show hidden files in Finder
defaults write com.apple.finder AppleShowAllFiles YES

# Create projects directory
mkdir -p "$HOME/projects"
symlink 'projects.sublime-project' "$HOME/projects"

# Zsh settings
symlink '.z*' "$HOME"
mkdir -p "$HOME/.zprofile.d"

# Git settings
symlink '.gitconfig' "$HOME"

# SSH settings
test -d "$HOME/.ssh" || ssh-keygen
symlink '.ssh/*' "$HOME"

# Ruby settings
symlink '.gemrc' "$HOME"
symlink '.rubocop.yml' "$HOME"

# Sublime settings
symlink '*.sublime-settings' "$HOME/Library/Application Support/Sublime Text 3/Packages/User"
symlink '*.sublime-keymap' "$HOME/Library/Application Support/Sublime Text 3/Packages/User"

# Squid settings
symlink squid.conf /usr/local/etc

# Miscellaneous scripts
symlink 'bin/*' /usr/local
hash -r
