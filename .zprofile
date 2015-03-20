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

# Pull in everything else we decided not to keep in source control
if [[ -d ~/.zprofile.d ]]; then
  source ~/.zprofile.d/*
fi
