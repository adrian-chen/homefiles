#!/usr/bin/env bash

set -eu

# Oh My ZSH
curl -L http://install.ohmyz.sh | sh

# Homebrew
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# rbenv
brew install rbenv ruby-build
