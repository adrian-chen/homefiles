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

# Show hidden files in finder
defaults write com.apple.finder AppleShowAllFiles YES

# Configure keyboard
defaults write NSGlobalDomain KeyRepeat -int 2
defaults write NSGlobalDomain InitialKeyRepeat -int 15

# Configure dock
defaults write com.apple.dock tilesize -int 32

# Configure screen saver
defaults write com.apple.screensaver "askForPassword" -int 1
defaults write com.apple.screensaver "askForPasswordDelay" -int 5
defaults -currentHost write com.apple.screensaver "idleTime" -int 300
defaults -currentHost write com.apple.screensaver "moduleDict" -dict-add "moduleName" -string "Computer Name"
defaults -currentHost write com.apple.screensaver "moduleDict" -dict-add "path" -string "/System/Library/Frameworks/ScreenSaver.framework/Resources/Computer Name.saver"
defaults -currentHost write com.apple.ScreenSaver.Basic "MESSAGE" -string "Hey kid, I'm a computer."

# Enable hot corner (start screen saver in bottom left)
defaults write com.apple.dock wvous-bl-corner -int 5
defaults write com.apple.dock wvous-bl-modifier -int 0

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

# Create projects directory
mkdir -p "$HOME/projects"
cp -v projects.sublime-project "$HOME/projects"

# Sublime settings
symlink '*.sublime-settings' "$HOME/Library/Application Support/Sublime Text 3/Packages/User"
symlink '*.sublime-keymap' "$HOME/Library/Application Support/Sublime Text 3/Packages/User"

# Squid settings
symlink squid.conf /usr/local/etc

# Test Kitchen settings
symlink .kitchen "$HOME"

# Miscellaneous scripts
symlink 'bin/*' /usr/local
hash -r
