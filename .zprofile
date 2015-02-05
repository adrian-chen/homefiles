# Make Sublime the default editor
if which subl > /dev/null 2>&1; then
  export EDITOR='subl -w'
fi

# Homebrew
if which brew > /dev/null 2>&1; then
  export PATH=/usr/local/bin:/usr/local/sbin:$PATH
fi

# rbenv
if which rbenv > /dev/null 2>&1; then
  export RBENV_ROOT=/usr/local/var/rbenv
  eval "$(rbenv init -)"
fi

# ChefDK
if which chef > /dev/null 2>&1; then
  eval "$(chef shell-init zsh)"
fi

# Squid proxy
#export http_proxy=http://localhost:3128
#export https_proxy=http://localhost:3128

source ~/.zprofile.d/*
