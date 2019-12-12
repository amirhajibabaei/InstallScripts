#! /bin/bash

version="2.14"
sourcedir="$HOME/.SUPER/sources"
prefix="$HOME/.SUPER/glibc/$version"
mkdir -p $sourcedir
mkdir -p $prefix


# get the source code
cd $sourcedir
if [[ -f glibc-${version}.tar.gz ]]; then
    echo file exists
else
    echo downloading
    wget http://ftp.gnu.org/gnu/glibc/glibc-${version}.tar.gz
fi
tar -xf glibc-${version}.tar.gz


# create the build directory
mkdir -p glibc-build
cd glibc-build
rm -rf *


# build
../glibc-${version}/configure       \
    --prefix=${prefix}            \
&& make -j8                       \
&& make -j8 install

# I had to install make 3.79 && ln -s gmake make && export LD_LIBRARY_PATH=''
# came into Error: `_obstack@GLIBC_2.2.5' can't be versioned to common symbol '_obstack_compat'
# all I had to do was to initialize this variable (just grep it!) to 0 in the source code.
# for common problems read: https://www.lordaro.co.uk/posts/2018-08-26-compiling-glibc.html
