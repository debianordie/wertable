set -Eex

export DEBIAN_FRONTEND=noninteractive

alias package='sudo apt-get --quiet --quiet --yes'
alias service='sudo systemctl --quiet'

ensure_dod_module () {
  if curl -sf "https://github.com/debianordie/${1}" >/dev/null; then
    if [ -d ~/.config/dod/${1} ]; then
      #git -C ~/.config/dod/config pull -q "~/.config/dod/${1}"
      echo
    else
      git clone -q https://github.com/debianordie/${1}.git ~/.config/dod/${1}
    fi
  else
    _error "module <${1}> does not exist"
  fi
}

run_dod_module () {
  if [ ! -d ~/.config/dod/${1} ]; then
    ensure_dod_module "${1}"
  fi
  if [ -f ~/.config/dod/${1}/config.sh ]; then
    . ~/.config/dod/${1}/config.sh
  else
    _error "~/.config/dod/${1} has not <config.sh> file"
  fi
}
