#!/bin/bash
# Get an updated config.sub and config.guess
cp $BUILD_PREFIX/share/gnuconfig/config.* ./bin/scripts

export CXXFLAGS=$(echo "${CXXFLAGS}" | sed "s/-std=c++17/-std=c++14/g")

mkdir -p ${PREFIX}/var/omniNames-logs
touch ${PREFIX}/var/omniNames-logs/.mkdir
mkdir -p ${PREFIX}/etc/omniORB-config
touch ${PREFIX}/etc/omniORB-config/.mkdir

mkdir build
[[ "$host_alias" == "$build_alias" ]] && autoconf
cd build
../configure --prefix="${PREFIX}" \
             --host=$host_alias \
             --build=$build_alias \
             --with-openssl \
             --with-omniORB-config="${PREFIX}/etc/omniORB-config/omniORB.cfg" \
             --with-omniNames-logdir="${PREFIX}/var/omniNames-logs"

if [[ "$host_alias" != "$build_alias" ]]
then
  echo "Build the IDL to Cpp compiler"
  make CC=$CC_FOR_BUILD -C src/tool/omniidl/cxx/cccp
  make CXX=$CXX_FOR_BUILD -C src/tool/omniidl/cxx
  make CC=$CC_FOR_BUILD -C src/tool/omkdepend
fi

make -j$CPU_COUNT
make install
