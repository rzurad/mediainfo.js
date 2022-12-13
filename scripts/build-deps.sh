#!/bin/bash

set -xe

LIBMEDIAINFO_VERSION=20.09
LIBZEN_VERSION=0.4.38

LIBMEDIAINFO_URL="https://mediaarea.net/download/source/libmediainfo/${LIBMEDIAINFO_VERSION}/libmediainfo_${LIBMEDIAINFO_VERSION}.tar.bz2"
LIBZEN_URL="https://mediaarea.net/download/source/libzen/${LIBZEN_VERSION}/libzen_${LIBZEN_VERSION}.tar.bz2"

source scripts/build-opts

mkdir -p build/vendor
cd build/vendor

# download sources
curl -sL ${LIBMEDIAINFO_URL} | tar -xj
curl -sL ${LIBZEN_URL} | tar -xj

# Zenlib
cd ZenLib/Project/GNU/Library/
./autogen.sh
emconfigure \
  ./configure \
  --host=le32-unknown-nacl \
  CFLAGS="${CFLAGS}" \
  CXXFLAGS="${CXXFLAGS}"
emmake make -j12
cd ../../../..

# MediaInfoLib
cd MediaInfoLib/Project/GNU/Library
./autogen.sh
emconfigure \
  ./configure \
  --host=le32-unknown-nacl \
  CFLAGS="${CFLAGS}" \
  CXXFLAGS="${CXXFLAGS} ${MediaInfoLib_CXXFLAGS}"
emmake make -j12