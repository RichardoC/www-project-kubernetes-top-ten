#!/bin/bash

set -eux

source JEKYLL_VERSION.sh

export _BINARY="docker"

if [ -x "$(command -v lima)" ]; then
  echo 'lima is installed so using it instead' >&2
  _BINARY="lima nerdctl "
elif [ -x "$(command -v nerdctl)" ]; then
  echo 'nerdctl is installed so using it instead' >&2
  _BINARY="nerdctl "
fi


$_BINARY run --rm --volume="$PWD:/srv/jekyll" --volume="jekyll:/usr/local/bundle" -it jekyll/jekyll:$JEKYLL_VERSION jekyll build -s /srv/jekyll/ -d /srv/jekyll/docs
