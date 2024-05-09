cd omniorb/src/lib/omniORBpy

# Get an updated config.sub and config.guess
cp $BUILD_PREFIX/share/gnuconfig/config.* ./bin/scripts

autoconf

mkdir build
cd build
../configure --prefix=$PREFIX --with-openssl
make -j$CPU_COUNT
make install
