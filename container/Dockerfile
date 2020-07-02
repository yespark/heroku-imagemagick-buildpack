FROM heroku/heroku:20-build

ARG DEBIAN_FRONTEND=noninteractive

ARG VERSION_LIBDE265=1.0.8
ARG VERSION_LIBHEIF=1.10.0
ARG VERSION_LIBWEBP=1.1.0

ARG VERSION_IMAGEMAGICK=7.0.10-53

RUN apt-get -yq update \
  # Install install the latest libde265 library
  && curl -sSL --retry 3 https://github.com/strukturag/libde265/releases/download/v$VERSION_LIBDE265/libde265-$VERSION_LIBDE265.tar.gz | tar zx \
  && cd libde265-$VERSION_LIBDE265 \
  && ./autogen.sh \
  && ./configure \
  && make -j$(nproc) \
  && make install \
  # Install install the latest libheif library
  && curl -sSL --retry 3 https://github.com/strukturag/libheif/releases/download/v$VERSION_LIBHEIF/libheif-$VERSION_LIBHEIF.tar.gz | tar zx \
  && cd libheif-$VERSION_LIBHEIF \
  && ./autogen.sh \
  && ./configure \
  && make -j$(nproc) \
  && make install \
  # Install install the latest libwebp library
  && curl -sSL --retry 3 http://storage.googleapis.com/downloads.webmproject.org/releases/webp/libwebp-$VERSION_LIBWEBP.tar.gz | tar zx \
  && cd libwebp-$VERSION_LIBWEBP \
  && ./autogen.sh \
  && ./configure \
  && make -j$(nproc) \
  && make install \
  # Get, configure and install imagemagick
  && curl -sSL https://imagemagick.org/download/releases/ImageMagick-$VERSION_IMAGEMAGICK.tar.bz2 | tar jx \
  && cd ImageMagick-$VERSION_IMAGEMAGICK \
  && ./configure --prefix=/usr/src/imagemagick --with-heic=yes --with-webp=yes --with-openexr=no --with-x=no --disable-docs \
  && make -j$(nproc) \
  && make install \
  # Copy shared libraries just compiled
  && cp /usr/local/lib/libde265.so.0 /usr/src/imagemagick/lib \
  && cp /usr/local/lib/libheif.so.1 /usr/src/imagemagick/lib \
  && cp /usr/local/lib/libwebp.so.7 /usr/src/imagemagick/lib \
  # Clean up the build and get ready for packaging
  && cd /usr/src/imagemagick \
  && strip lib/*.a lib/lib*.so* \
  # Wrap it up with a bow (compress the binary)
  && rm -rf build \
  && mkdir build \
  && tar cjf /usr/src/imagemagick/build/imagemagick.tar.bz2 bin include lib
