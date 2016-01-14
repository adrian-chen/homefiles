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

# Install Xcode Command Line Tools
if [[ ! -d /Library/Developer/CommandLineTools ]]; then
  xcode-select --install
  printf "\nTo continue, please rerun this script after the Xcode Command Line Tools are installed.\n"
  exit 1
fi

# Install Homebrew and bundled packages
if ! command -v brew >/dev/null 2>&1; then
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi
brew bundle

# Download Homebrew uninstaller
wget -nc -P $(brew --prefix)/bin https://gist.githubusercontent.com/mxcl/1173223/raw/a833ba44e7be8428d877e58640720ff43c59dbad/uninstall_homebrew.sh
chmod +x $(brew --prefix)/bin/uninstall_homebrew.sh

# Install zgen
ZGEN_PATH="$HOME/.zgen"
if [[ ! -d "$ZGEN_PATH" ]]; then
  git clone https://github.com/tarjoilija/zgen.git "ZGEN_PATH"
fi

# Change default shell if necessary
ZSH_PATH="$(brew --prefix)/bin/zsh"
if [[ "$SHELL" != "$ZSH_PATH" ]]; then
  sudo chsh -s "$ZSH_PATH" "$USER"
fi

# Download Solarized theme
for f in Solarized%20Dark.itermcolors Solarized%20Light.itermcolors; do
  wget -nc -P "$HOME/Documents" "https://raw.githubusercontent.com/altercation/solarized/master/iterm2-colors-solarized/$f"
done

# Install Package Control for Sublime Text 3
wget -nc -P "$HOME/Library/Application Support/Sublime Text 3/Installed Packages" https://packagecontrol.io/Package%20Control.sublime-package

# Install PyYAML for SublimeLinter-pyyaml
pip3 install pyyaml

# Set up rbenv/ChefDK cohabitation
mkdir -p "$(rbenv root)/plugins"
git clone https://github.com/docwhat/rbenv-chefdk.git "$(rbenv root)/plugins/rbenv-chefdk" || true
mkdir -p "$(rbenv root)/versions/chefdk"

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
test -d "$HOME/.kitchen" || symlink '.kitchen' "$HOME"

# Miscellaneous scripts
symlink 'bin/*' /usr/local
hash -r

printf "\nSuccess!\n"
