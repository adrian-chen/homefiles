# Make Sublime the default editor
if command -v subl >/dev/null 2>&1; then
  export EDITOR='subl -w'
fi

# Homebrew
if commmand -v brew > /dev/null 2>&1; then
  export PATH=/usr/local/bin:/usr/local/sbin:$PATH
fi

# rbenv
if command -v rbenv > /dev/null 2>&1; then
  eval "$(rbenv init -)"
fi

# Pull in everything else we decided not to keep in source control
if [[ -d ~/.zprofile.d ]]; then
  source ~/.zprofile.d/*
fi
