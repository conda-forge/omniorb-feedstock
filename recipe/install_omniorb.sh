echo "Creating $PKG_NAME"

cd build
make install

mkdir -p ${PREFIX}/var/omniNames-logs
touch ${PREFIX}/var/omniNames-logs/.mkdir
mkdir -p ${PREFIX}/etc/omniORB-config
touch ${PREFIX}/etc/omniORB-config/.mkdir
