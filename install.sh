#!/usr/bin/env bash

set -eu

# Oh My ZSH
curl -L http://install.ohmyz.sh | sh

# Homebrew
which brew || ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew install caskroom/cask/brew-cask

# Sublime Text 3
brew tap caskroom/versions
brew cask install sublime-text3

# iTerm2
brew cask install iterm2

# rbenv
brew install rbenv ruby-build
