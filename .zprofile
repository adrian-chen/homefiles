# Make Sublime the default editor
if command -v subl >/dev/null 2>&1; then
  export EDITOR='subl -w'
fi

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
if [[ -f ~/.aws/config ]]; then
  export AWS_DEFAULT_REGION=$(python -c "import ConfigParser; c = ConfigParser.ConfigParser(); c.read('.aws/config'); print c.get('default', 'region')")
  export EC2_REGION=$AWS_DEFAULT_REGION
fi

# rbenv/ChefDK
if command -v rbenv > /dev/null 2>&1; then
  eval "$(rbenv init -)"
elif command -v chef > /dev/null 2>&1; then
  eval "$(chef shell-init zsh)"
fi

# Vagrant and Test Kitchen
export VAGRANT_HTTP_PROXY=http://10.0.2.2:3128
export VAGRANT_HTTPS_PROXY=http://10.0.2.2:3128

# Pull in everything else we decided not to keep in source control
if [ "$(ls -A ~/.zprofile.d)" ]; then
  source ~/.zprofile.d/*
fi
