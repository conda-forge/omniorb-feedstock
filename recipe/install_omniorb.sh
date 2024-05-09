cd build

make install

if [[ "$PKG_NAME" == "omniorb" ]]; then
  mkdir -p ${PREFIX}/var/omniNames-logs
  touch ${PREFIX}/var/omniNames-logs/.mkdir
  mkdir -p ${PREFIX}/etc/omniORB-config
  touch ${PREFIX}/etc/omniORB-config/.mkdir
fi

if [[ "$PKG_NAME" == "omniorb-libs" ]]; then
  echo "Removing files we don't want in omniorb-libs"
  rm -f $PREFIX/bin/catior
  rm -f $PREFIX/bin/convertior
  rm -f $PREFIX/bin/genior
  rm -f $PREFIX/bin/nameclt
  rm -f $PREFIX/bin/omkdepend
  rm -f $PREFIX/bin/omni*
  rm -f $PREFIX/lib/libomni*.a
  rm -f $PREFIX/lib/libCOS*.a
  rm -f $PREFIX/lib/python*/site-packages/_omniidl*
  rm -rf $PREFIX/lib/python*/site-packages/omniidl*
  rm -rf $PREFIX/share/idl/omniORB
fi
