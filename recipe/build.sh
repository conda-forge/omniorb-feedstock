#!/bin/bash

echo "Compile omniORB"
# Get an updated config.sub and config.guess
cp $BUILD_PREFIX/share/gnuconfig/config.* ./bin/scripts

autoconf

if [[ "$host_alias" != "$build_alias" ]]
then
  echo "Compile native omniorb in BUILD_PREFIX for cross-compilation"
  # The normal build makes various tools that are used later in the build, in
  # particular omniidl. When cross-compiling, the tools must already be
  # available for your native platform.
  # Compile for native platform first.
  # With 4.3.0, we have to pass --disable-longdouble here as well,
  # otherwise arm compilation fails (longdouble is used)
  mkdir -p ${BUILD_PREFIX}/var/omniNames-logs
  touch ${BUILD_PREFIX}/var/omniNames-logs/.mkdir
  mkdir -p ${BUILD_PREFIX}/etc/omniORB-config
  touch ${BUILD_PREFIX}/etc/omniORB-config/.mkdir

  mkdir build-native
  cd build-native

  LDFLAGS_FOR_BUILD=$(echo $LDFLAGS | sed "s?$PREFIX?$BUILD_PREFIX?g")
  LDFLAGS_LD_FOR_BUILD=$(echo $LDFLAGS_LD | sed "s?$PREFIX?$BUILD_PREFIX?g")
  ../configure --prefix="${BUILD_PREFIX}" \
               --host=$build_alias \
               --build=$build_alias \
               --with-openssl \
               --disable-longdouble \
               --with-omniORB-config="${BUILD_PREFIX}/etc/omniORB-config/omniORB.cfg" \
               --with-omniNames-logdir="${BUILD_PREFIX}/var/omniNames-logs" \
               CC=$CC_FOR_BUILD \
               CXX=$CXX_FOR_BUILD \
               AR=${build_alias}-ar \
               LD=${build_alias}-ld \
               RANLIB=${build_alias}-ranlib \
               LDFLAGS="$LDFLAGS_FOR_BUILD" \
               LDFLAGS_LD="$LDFLAGS_LD_FOR_BUILD"
  make -j$CPU_COUNT
  make install
  cd ..

  # Extra options to cross compile
  # --disable-longdouble is needed on Apple silicon
  # sizeof long double is 8 (same as long)
  CONFIGURE_CROSS_OPTIONS="--host=$host_alias --build=$build_alias --disable-longdouble"
fi

mkdir build
cd build
../configure --prefix="${PREFIX}" $CONFIGURE_CROSS_OPTIONS \
             --with-openssl \
             --with-omniORB-config="${PREFIX}/etc/omniORB-config/omniORB.cfg" \
             --with-omniNames-logdir="${PREFIX}/var/omniNames-logs"

# Check found SSL variables
grep SSL config.status

make -j$CPU_COUNT
