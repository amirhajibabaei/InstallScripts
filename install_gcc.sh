#! /bin/bash

version="9.1.0"
sourcedir="$HOME/.SUPER/sources"
prefix="$HOME/.SUPER/gcc/$version"
mkdir -p $sourcedir
mkdir -p $prefix


# get the source code
cd $sourcedir
if [[ -f gcc-${version}.tar.gz ]]; then
    echo file exists
else
    echo downloading
    wget http://www.netgull.com/gcc/releases/gcc-${version}/gcc-${version}.tar.gz
fi
tar -xf gcc-${version}.tar.gz

# download the prerequisites
cd gcc-${version}
./contrib/download_prerequisites

# create the build directory
cd ..
mkdir -p gcc-build
cd gcc-build
rm -rf *


# if make failed, uncomment the following line and try again
#unset LIBRARY_PATH CPATH C_INCLUDE_PATH PKG_CONFIG_PATH CPLUS_INCLUDE_PATH INCLUDE  

# build
../gcc-${version}/configure       \
    --prefix=${prefix}            \
    --enable-languages=all        \
    --disable-multilib            \
&& make -j8                       \
&& make -j8 install
