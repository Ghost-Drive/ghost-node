#!/usr/bin/env sh

_exists() {
  cmd="$1"
  if [ -z "$cmd" ] ; then
    echo "Usage: _exists cmd"
    return 1
  fi
  if type command >/dev/null 2>&1 ; then
    command -v $cmd >/dev/null 2>&1
  else
    type $cmd >/dev/null 2>&1
  fi
  ret="$?"
  return $ret
}

if [ -z "$BRANCH" ]; then
  BRANCH="main"
fi

if _exists curl; then
  curl -s https://raw.githubusercontent.com/Ghost-Drive/ghost-node/$BRANCH/docker/docker-install.sh -o docker-install.sh \
    && sudo sh ./docker-install.sh && rm -f docker-install.sh
elif _exists wget; then
  wget -qO - https://raw.githubusercontent.com/Ghost-Drive/ghost-node/$BRANCH/docker/docker-install.sh \
    && sudo sh ./docker-install.sh && rm -f docker-install.sh
else
  echo "Sorry, you must have curl or wget installed first."
  echo "Please install either of them and try again."
fi