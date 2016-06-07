# Load Antigen
source "$HOME/.antigen/antigen.zsh"
antigen use oh-my-zsh
antigen theme gentoo
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-completions
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-history-substring-search
antigen apply

# iTerm2 Shell Integration
if [ -e "$HOME/.iterm2_shell_integration.zsh" ]; then
  source "$HOME/.iterm2_shell_integration.zsh"
fi

# Homebrew
if command -v brew > /dev/null 2>&1; then
  export PATH=/usr/local/bin:/usr/local/sbin:$PATH
  export HOMEBREW_GITHUB_API_TOKEN=$(<~/.homebrew_github_api_token)
fi

# AWS
export AWS_ACCESS_KEY_ID=$(aws configure get aws_access_key_id)
export AWS_SECRET_ACCESS_KEY=$(aws configure get aws_secret_access_key)
export AWS_REGION=$(aws configure get region)

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
  for f in ~/.zprofile.d/*; do
    source $f;
  done
fi

#export RUBYOPT="-W0"
export EDITOR=vim
