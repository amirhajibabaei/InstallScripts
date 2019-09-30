#! /bin/bash

series="2.0"
minor="2"
version=$series.$minor

SOURCE=scalapack-$version
WORKDIR="$HOME/.SUPER/sources"
prefix="$HOME/.SUPER/scalapack"
libdir="$HOME/.SUPER/OpenBLAS/lib"

mkdir -p $WORKDIR
mkdir -p $prefix


# get the source code
cd $WORKDIR
if [[ -f  "$SOURCE.tgz" ]]; then
    echo $SOURCE.tgz exists
else
    echo downloading
    wget http://www.netlib.org/scalapack/$SOURCE.tgz
fi

rm -rf $SOURCE
tar -xf $SOURCE.tgz
cd $SOURCE

# a patch for MPI4+ compatiability
for i in `grep -rlI "MPI_Type_struct" *`; do sed -i 's/MPI_Type_struct/MPI_Type_create_struct/g' $i; done

# make
cp SLmake.inc.example SLmake.inc
sed -i "s~FCFLAGS       = -O3~FCFLAGS       = -march=native -O3~g" SLmake.inc
sed -i "s~CCFLAGS       = -O3~CCFLAGS       = -march=native -O3~g" SLmake.inc
sed -i "s~LIBS          =.*~LIBS          = $libdir/libopenblas.so~g" SLmake.inc
make

# install
mkdir -p $prefix/lib
cp libscalapack.a $prefix/lib/
