#
# Defines environment variables.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Ensure that a non-login, non-interactive shell has a defined environment.
if [[ ( "$SHLVL" -eq 1 && ! -o LOGIN ) && -s "${ZDOTDIR:-$HOME}/.zprofile" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprofile"
fi

export DEFAULT_USER=$USER

export WORKON_HOME=$HOME/virtualenvs
export PROJECT_HOME=$HOME
# source /usr/local/bin/virtualenvwrapper.sh

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
export PATH="$PATH:/Applications/Postgres.app/Contents/Versions/latest/bin/"
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi
