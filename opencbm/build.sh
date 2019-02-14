#!/bin/bash

PACKAGE=$(basename $(pwd))
VERSION=0.4.99.99
SOURCE=https://sourceforge.net/projects/${PACKAGE}/files/${PACKAGE}/${PACKAGE}-${VERSION}/${PACKAGE}-${VERSION}.tar.bz2

wget ${SOURCE}

mv ${PACKAGE}-${VERSION}.tar.gz ${PACKAGE}_${VERSION}.orig.tar.gz
tar xf ${PACKAGE}_${VERSION}.orig.tar.gz
sed -i "s/usr\/local/usr/" ${PACKAGE}/LINUX/config.make

cd ${PACKAGE}-${VERSION}
dh_make -s -y
cat ../control > debian/control
sed "s@CHANGEME@$(pwd)@g" ../rules >> debian/rules
dpkg-buildpackage -b

exit 0
