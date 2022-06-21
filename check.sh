#!/usr/bin/env bash
set -e

COMPILE_VERSION_LIBDE265=$(cat container/Dockerfile | egrep -o 'COMPILE_VERSION_LIBDE265=([0-9.-]+)' | cut -f 2 -d =)
COMPILE_VERSION_LIBHEIF=$(cat container/Dockerfile | egrep -o 'COMPILE_VERSION_LIBHEIF=([0-9.-]+)' | cut -f 2 -d =)
COMPILE_VERSION_LIBWEBP=$(cat container/Dockerfile | egrep -o 'COMPILE_VERSION_LIBWEBP=([0-9.-]+)' | cut -f 2 -d =)
COMPILE_VERSION_IMAGEMAGICK=$(cat container/Dockerfile | egrep -o 'COMPILE_VERSION_IMAGEMAGICK=([0-9.-]+)' | cut -f 2 -d =)

LATEST_VERSION_LIBDE265=$(curl -s "https://api.github.com/repos/strukturag/libde265/releases/latest" | jq -r .tag_name | sed 's/v//')
LATEST_VERSION_LIBHEIF=$(curl -s "https://api.github.com/repos/strukturag/libheif/releases/latest" | jq -r .tag_name | sed 's/v//')
LATEST_VERSION_LIBWEBP=$(curl -s "https://api.github.com/repos/webmproject/libwebp/tags" | jq -r '.[0].name' | sed 's/v//')
LATEST_VERSION_IMAGEMAGICK=$(curl -s "https://api.github.com/repos/ImageMagick/ImageMagick/releases/latest" | jq -r .tag_name | sed 's/v//')

if [ "$COMPILE_VERSION_LIBDE265" != "$LATEST_VERSION_LIBDE265" ]; then
  echo "[NEW UPDATE] COMPILE_VERSION_LIBDE265     $COMPILE_VERSION_LIBDE265 🔄 $LATEST_VERSION_LIBDE265"
fi

if [ "$COMPILE_VERSION_LIBHEIF" != "$LATEST_VERSION_LIBHEIF" ]; then
  echo "[NEW UPDATE] COMPILE_VERSION_LIBHEIF      $COMPILE_VERSION_LIBHEIF 🔄 $LATEST_VERSION_LIBHEIF"
fi

if [ "$COMPILE_VERSION_LIBWEBP" != "$LATEST_VERSION_LIBWEBP" ]; then
  echo "[NEW UPDATE] COMPILE_VERSION_LIBWEBP      $COMPILE_VERSION_LIBWEBP 🔄 $LATEST_VERSION_LIBWEBP"
fi

if [ "$COMPILE_VERSION_IMAGEMAGICK" != "$LATEST_VERSION_IMAGEMAGICK" ]; then
  echo "[NEW UPDATE] COMPILE_VERSION_IMAGEMAGICK  $COMPILE_VERSION_IMAGEMAGICK 🔄 $LATEST_VERSION_IMAGEMAGICK"
fi
