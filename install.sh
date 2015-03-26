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

# We need PyYAML for SublimeLinter-pyyaml
pip3 install pyyaml

# rbenv/ChefDK cohabitation
mkdir -p $(rbenv root)/plugins
git clone https://github.com/docwhat/rbenv-chefdk.git $(rbenv root)/plugins/rbenv-chefdk || true
mkdir -p $(rbenv root)/versions/chefdk

# FIXME: Fix for https://github.com/SublimeLinter/SublimeLinter3/issues/227
# Hopefully fixed in Chefdk > 0.4.0
sudo wget -nc -P /opt/chefdk/embedded/lib/ruby/site_ruby/2.1.0/rubygems/defaults/operating_system.rb https://github.com/chef/omnibus-chef/blob/ba89fea5929c2a87c7619013be2716c89f897e20/files/rubygems-customization/default/operating_system.rb
