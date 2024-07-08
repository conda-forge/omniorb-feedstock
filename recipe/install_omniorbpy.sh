echo "Compile omniORBpy"

if [[ "$host_alias" != "$build_alias" ]]
then
  echo "Install the native omniorb in the new BUILD_PREFIX"
  cd build-native

  LDFLAGS_FOR_BUILD=$(echo $LDFLAGS | sed "s?$PREFIX?$BUILD_PREFIX?g")
  LDFLAGS_LD_FOR_BUILD=$(echo $LDFLAGS_LD | sed "s?$PREFIX?$BUILD_PREFIX?g")
  ../configure --prefix="${BUILD_PREFIX}" \
               --host=$build_alias \
               --build=$build_alias \
               --with-openssl \
               --disable-longdouble \
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
  CONFIGURE_CROSS_OPTIONS="--host=$host_alias --build=$build_alias --with-omniorb=$BUILD_PREFIX"
fi

cd src/lib/omniORBpy

# Get an updated config.sub and config.guess
cp $BUILD_PREFIX/share/gnuconfig/config.* ./bin/scripts

autoconf

mkdir build
cd build
../configure --prefix=$PREFIX --with-openssl $CONFIGURE_CROSS_OPTIONS

# Check found SSL variables
grep SSL config.status

make -j$CPU_COUNT
make install
