#! /bin/bash

series="4.0"
minor="2rc3"
version=$series.$minor

SOURCE=openmpi-$version
WORKDIR="$HOME/.SUPER/sources"
INSTALLDIR="$HOME/.SUPER/openmpi/$version"

mkdir -p $WORKDIR
mkdir -p $INSTALLDIR


# get the source code
cd $WORKDIR
if [[ -f  "$SOURCE.tar.gz" ]]; then
    echo file exists
else
    echo downloading
    wget https://download.open-mpi.org/release/open-mpi/v$series/$SOURCE.tar.gz
fi

rm -rf $SOURCE
tar -xf $SOURCE.tar.gz

# create the build directory
mkdir -p openmpi-build
cd openmpi-build
rm -rf *

# build
../$SOURCE/configure                    \
    --prefix=${INSTALLDIR}              \
&& make -j8 \
&& make -j8 install

