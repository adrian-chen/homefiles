#!/usr/bin/env bash

# Oh My ZSH
curl -L http://install.ohmyz.sh | sh

# Homebrew
which brew || ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew install caskroom/cask/brew-cask

# Miscellaneous Utilities
for f in ag coreutils git gnu-sed nmap pssh rename tcpdump watch wget; do
  brew install $f
done

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
brew install rbenv
brew install ruby-build

# Google
brew cask install google-drive
brew cask install google-chrome

# Flux
brew cask install flux

# Amazon Web Services
brew install awscli
