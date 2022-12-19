# syntax=docker/dockerfile-upstream:master-labs
ARG DOCKER_FROM

FROM $DOCKER_FROM

ENV DEBIAN_FRONTEND=noninteractive

ARG COMPILE_VERSION_LIBDE265
ARG COMPILE_VERSION_LIBWEBP
ARG COMPILE_VERSION_LIBHEIF
ARG COMPILE_VERSION_IMAGEMAGICK

ENV DOWNLOAD_URL_LIBDE265="https://github.com/strukturag/libde265/releases/download/v${COMPILE_VERSION_LIBDE265}/libde265-${COMPILE_VERSION_LIBDE265}.tar.gz"
ENV DOWNLOAD_URL_LIBWEBP="http://storage.googleapis.com/downloads.webmproject.org/releases/webp/libwebp-${COMPILE_VERSION_LIBWEBP}.tar.gz"
ENV DOWNLOAD_URL_LIBHEIF="https://github.com/strukturag/libheif/releases/download/v$COMPILE_VERSION_LIBHEIF/libheif-$COMPILE_VERSION_LIBHEIF.tar.gz"
ENV DOWNLOAD_URL_IMAGEMAGICK="https://github.com/ImageMagick/ImageMagick/archive/refs/tags/${COMPILE_VERSION_IMAGEMAGICK}.tar.gz"

RUN <<-EOF
  # Enables a mode of the shell where all executed commands are printed to the terminal.
  set -x

  # Update packages from the stack
  apt-get -y update

  # libde265 library
  curl -sSL $DOWNLOAD_URL_LIBDE265 | tar zx
  cd libde265-$COMPILE_VERSION_LIBDE265
  ./autogen.sh
  ./configure
  make V=0 --jobs=$(nproc --ignore=2)
  make install --jobs=$(nproc --ignore=2)
  cd ..

  # libwebp library
  curl -sSL $DOWNLOAD_URL_LIBWEBP | tar zx
  cd libwebp-$COMPILE_VERSION_LIBWEBP
  ./autogen.sh
  ./configure --enable-shared --enable-libwebpdecoder --enable-libwebpdemux --enable-libwebpmux --enable-static=no
  make V=0 --jobs=$(nproc --ignore=2)
  make install --jobs=$(nproc --ignore=2)
  cd ..

  # libheif library
  curl -sSL $DOWNLOAD_URL_LIBHEIF | tar zx
  cd libheif-$COMPILE_VERSION_LIBHEIF
  ./autogen.sh
  ./configure
  make V=0 --jobs=$(nproc --ignore=2)
  make install --jobs=$(nproc --ignore=2)
  cd ..

  # ImageMagick
  curl -sSL $DOWNLOAD_URL_IMAGEMAGICK | tar zx
  cd ImageMagick-$COMPILE_VERSION_IMAGEMAGICK
  ./configure --prefix=/usr/src/imagemagick --disable-docs --with-avif=yes --with-heic=yes --with-webp=yes --with-tiff=yes --with-openexr=no --with-x=no
  make V=0 --jobs=$(nproc --ignore=2)
  make install
  make check
  cd ..

  # creates the necessary links and cache to the most recent shared libraries found in the directory /usr/local/lib
  ldconfig /usr/local/lib

  # copy shared libraries just compiled
  cp /usr/local/lib/libde265* /usr/local/lib/libheif* /usr/local/lib/libwebp* /usr/src/imagemagick/lib/

  # clean up the build and get ready for packaging
  cd /usr/src/imagemagick
  strip lib/*.a lib/lib*.so*
  ls -lha share/
  rm -rf share/gtk-doc
  rm -rf share/man
  rm -rf share/thumbnailers
  ls -lha lib/

  # build tar.bz2
  rm -rf build
  mkdir build
  tar cjf /usr/src/imagemagick/build/imagemagick.tar.bz2 bin include lib etc share
EOF
