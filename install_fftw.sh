#! /bin/bash

series="3.3"
minor="8"
version=$series.$minor

SOURCE=fftw-$version
WORKDIR="$HOME/.SUPER/sources"
INSTALLDIR="$HOME/.SUPER/numerical"

mkdir -p $WORKDIR
mkdir -p $INSTALLDIR


# get the source code
cd $WORKDIR
if [[ -f  "$SOURCE.tar.gz" ]]; then
    echo file exists
else
    echo downloading
    wget http://fftw.org/$SOURCE.tar.gz
fi

rm -rf $SOURCE
tar -xf $SOURCE.tar.gz

# create the build directory
mkdir -p fftw-build
cd fftw-build
rm -rf *

# build
../$SOURCE/configure                    \
    CC=mpicc                            \
    CFLAGS='-march=native -O3'          \
    --enable-shared                     \
    --enable-mpi                        \
    --enable-openmp                     \
    --prefix=${INSTALLDIR}              \
&& make -j8 \
&& make -j8 install

