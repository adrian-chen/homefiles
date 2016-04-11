export EDITOR=vim

# Homebrew
if command -v brew > /dev/null 2>&1; then
  export PATH=/usr/local/bin:/usr/local/sbin:$PATH
  export HOMEBREW_GITHUB_API_TOKEN=$(<~/.homebrew_github_api_token)
fi

# AWS
if [[ -f ~/.aws/credentials ]]; then
  export AWS_ACCESS_KEY_ID=$(python -c "import ConfigParser; c = ConfigParser.ConfigParser(); c.read('.aws/credentials'); print c.get('default', 'aws_access_key_id')")
  export AWS_SECRET_ACCESS_KEY=$(python -c "import ConfigParser; c = ConfigParser.ConfigParser(); c.read('.aws/credentials'); print c.get('default', 'aws_secret_access_key')")
fi
if [[ -f ~/.aws/config && "$(grep region ~/.aws/config)" ]]; then
  export AWS_DEFAULT_REGION=$(python -c "import ConfigParser; c = ConfigParser.ConfigParser(); c.read('.aws/config'); print c.get('default', 'region')")
  export EC2_REGION=$AWS_DEFAULT_REGION
fi

# rbenv/ChefDK
# if command -v rbenv > /dev/null 2>&1; then
#   eval "$(rbenv init -)"
# elif command -v chef > /dev/null 2>&1; then
#   eval "$(chef shell-init zsh)"
# fi

# Vagrant and Test Kitchen
export VAGRANT_HTTP_PROXY=http://10.0.2.2:3128
export VAGRANT_HTTPS_PROXY=http://10.0.2.2:3128

# Pull in everything else we decided not to keep in source control
if [ "$(ls -A ~/.zprofile.d)" ]; then
  for f in ~/.zprofile.d/*; do
    source $f;
  done
fi

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
