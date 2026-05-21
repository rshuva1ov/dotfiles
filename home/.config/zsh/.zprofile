# Login shell: Homebrew (Apple Silicon) before /usr/local in PATH.
# /etc/zprofile runs path_helper first; with ZDOTDIR, ~/.zprofile in $HOME is ignored.
if [[ -x /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

if [[ -d /opt/homebrew/bin ]]; then
  typeset -U path
  path=(/opt/homebrew/bin /opt/homebrew/sbin ${path:#/opt/homebrew/bin} ${path:#/opt/homebrew/sbin})
fi
