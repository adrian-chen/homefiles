# Make Sublime the default editor
if command -v subl >/dev/null 2>&1; then
  export EDITOR='subl -w'
fi

# Homebrew
if command -v brew > /dev/null 2>&1; then
  export PATH=/usr/local/bin:/usr/local/sbin:$PATH
  export HOMEBREW_GITHUB_API_TOKEN=$(<~/.homebrew_github_api_token)
fi

# rbenv/ChefDK
if command -v rbenv > /dev/null 2>&1; then
  eval "$(rbenv init -)"
elif command -v chef > /dev/null 2>&1; then
  eval "$(chef shell-init zsh)"
fi

# AWS
if [[ -f ~/.aws/credentials ]]; then
  export AWS_ACCESS_KEY_ID=$(ruby -rinifile -e "puts IniFile.load(File.join(File.expand_path('~'), '.aws', 'credentials'))['default']['aws_access_key_id']")
  export AWS_SECRET_ACCESS_KEY=$(ruby -rinifile -e "puts IniFile.load(File.join(File.expand_path('~'), '.aws', 'credentials'))['default']['aws_secret_access_key']")
fi
if [[ -f ~/.aws/config ]]; then
  export AWS_DEFAULT_REGION=$(ruby -rinifile -e "puts IniFile.load(File.join(File.expand_path('~'), '.aws', 'config'))['default']['region']")
  export EC2_REGION=$AWS_DEFAULT_REGION
fi

# Pull in everything else we decided not to keep in source control
if [ "$(ls -A ~/.zprofile.d)" ]; then
  source ~/.zprofile.d/*
fi
