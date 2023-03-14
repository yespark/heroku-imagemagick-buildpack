#!/usr/bin/env bash
set -x -e

# rm -rf build
mkdir -p build

DOCKER_FROM=heroku/heroku:22-build

BUILD_SHARED_LIBRARY=true

COMPILE_VERSION_LIBDE265=1.0.11
COMPILE_VERSION_LIBWEBP=1.3.0
COMPILE_VERSION_LIBHEIF=1.15.1
COMPILE_VERSION_IMAGEMAGICK=7.1.1-3

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
  --build-arg BUILD_SHARED_LIBRARY=$BUILD_SHARED_LIBRARY \
  container

if $BUILD_SHARED_LIBRARY
then
  docker run --rm -t -v $PWD/build:/data heroku-imagemagick sh -c 'cp -f /usr/src/imagemagick/build/*.tar.bz2 /data/'
fi
