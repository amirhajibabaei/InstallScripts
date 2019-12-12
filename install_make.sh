#! /bin/bash

version="3.79"
sourcedir="$HOME/.SUPER/sources"
prefix="$HOME/.SUPER/common/dummy"
mkdir -p $sourcedir
mkdir -p $prefix


# get the source code
cd $sourcedir
if [[ -f make-${version}.tar.gz ]]; then
    echo file exists
else
    echo downloading
    wget http://ftp.gnu.org/gnu/make/make-${version}.tar.gz
fi
tar -xf make-${version}.tar.gz


# create the build directory
mkdir -p make-build
cd make-build
rm -rf *

#
# build
../make-${version}/configure       \
    --prefix=${prefix}            \
&& make -j8                       \
&& make -j8 install
