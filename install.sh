#!/usr/bin/env bash

set -eu

# Homebrew
command -v brew >/dev/null 2>&1 || ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew tap Homebrew/brewdler
brew brewdle

# Homebrew uninstaller
wget -nc -P /usr/local/bin https://gist.githubusercontent.com/mxcl/1173223/raw/a833ba44e7be8428d877e58640720ff43c59dbad/uninstall_homebrew.sh
chmod +x /usr/local/bin/uninstall_homebrew.sh

# Oh My ZSH
curl -Ls http://install.ohmyz.sh | sh

# Solarized theme
for f in Solarized%20Dark.itermcolors Solarized%20Light.itermcolors; do
  wget -nc -P $HOME/Documents https://raw.githubusercontent.com/altercation/solarized/master/iterm2-colors-solarized/$f
done

# Package Control for Sublime Text 3
wget -nc -P "$HOME/Library/Application Support/Sublime Text 3/Installed Packages" https://packagecontrol.io/Package%20Control.sublime-package

# rbenv/ChefDK cohabitation
mkdir -p $(rbenv root)/plugins
git clone https://github.com/docwhat/rbenv-chefdk.git $(rbenv root)/plugins/rbenv-chefdk || true
mkdir -p $(rbenv root)/versions/chefdk
