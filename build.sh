#!/usr/bin/env bash
set -e
docker build --no-cache --pull -t heroku-imagemagick container
mkdir -p build
docker run --rm -t -v $PWD/build:/data heroku-imagemagick sh -c 'cp -f /usr/src/imagemagick/build/*.tar.bz2 /data/'
