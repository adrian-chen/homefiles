#!/usr/bin/env bash

set -eu

# Oh My ZSH
curl -L http://install.ohmyz.sh | sh

# Homebrew
which brew || ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew install caskroom/cask/brew-cask

# Miscellaneous Utilities
brew install wget

# Sublime Text 3
brew tap caskroom/versions
brew cask install sublime-text3
wget -nc -P "$HOME/Library/Application Support/Sublime Text 3/Installed Packages" https://packagecontrol.io/Package%20Control.sublime-package

# iTerm2
brew cask install iterm2
for f in Solarized%20Dark.itermcolors Solarized%20Light.itermcolors; do
  wget -nc -P $HOME/Documents https://raw.githubusercontent.com/altercation/solarized/master/iterm2-colors-solarized/$f
done

# rbenv
brew install rbenv ruby-build

# Chrome
brew cask install google-chrome

# Flux
brew cask install flux
