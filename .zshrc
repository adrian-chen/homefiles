# load zgen
source "${HOME}/.zgen/zgen.zsh"

# check if there's no init script
if ! zgen saved; then
    echo "Creating a zgen save"

    zgen oh-my-zsh

    # plugins
    zgen oh-my-zsh plugins/git
    zgen oh-my-zsh plugins/gitfast
    zgen oh-my-zsh plugins/git-extras
    zgen oh-my-zsh plugins/sudo
    zgen oh-my-zsh plugins/capistrano
    zgen oh-my-zsh plugins/osx
    zgen oh-my-zsh plugins/bundler
    zgen oh-my-zsh plugins/gem
    #zgen oh-my-zsh plugins/rails #currently broken
    zgen oh-my-zsh plugins/ruby
    zgen oh-my-zsh plugins/rbenv
    zgen oh-my-zsh plugins/nvm
    zgen oh-my-zsh plugins/screen
    zgen oh-my-zsh plugins/rake-fast
    zgen oh-my-zsh plugins/bower
    zgen oh-my-zsh plugins/sublime
    zgen oh-my-zsh plugins/gpg-agent

    zgen load zsh-users/zsh-syntax-highlighting
    zgen load caarlos0/zsh-add-upstream
    zgen load peterhurford/git-it-on.zsh
    zgen load mollifier/cd-gitroot
    zgen load skx/sysadmin-util

    zgen load StackExchange/blackbox

    # completions
    zgen load zsh-users/zsh-completions src

    # theme
    zgen oh-my-zsh themes/gentoo

    # save all to init script
    zgen save
fi
