#!/usr/bin/env bash
set -x -e

rm -rf build
mkdir build

DOCKER_FROM=heroku/heroku:22-build

COMPILE_VERSION_LIBDE265=1.0.9
COMPILE_VERSION_LIBWEBP=1.2.4
COMPILE_VERSION_LIBHEIF=1.14.0
COMPILE_VERSION_IMAGEMAGICK=7.1.0-55

DOCKER_BUILDKIT=1 docker build \
  --no-cache \
  --tag heroku-imagemagick \
  --pull \
    --progress=plain \
  --build-arg DOCKER_FROM=$DOCKER_FROM \
  --build-arg COMPILE_VERSION_LIBDE265=$COMPILE_VERSION_LIBDE265 \
  --build-arg COMPILE_VERSION_LIBWEBP=$COMPILE_VERSION_LIBWEBP \
  --build-arg COMPILE_VERSION_LIBHEIF=$COMPILE_VERSION_LIBHEIF \
  --build-arg COMPILE_VERSION_IMAGEMAGICK=$COMPILE_VERSION_IMAGEMAGICK \
  container

docker run --rm -t -v $PWD/build:/data heroku-imagemagick sh -c 'cp -f /usr/src/imagemagick/build/*.tar.bz2 /data/'
