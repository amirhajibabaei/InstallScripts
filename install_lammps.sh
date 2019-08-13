prefix=$HOME/.SUPER/lammps
sources=$HOME/.SUPER/sources
branch=stable


# go to source
cd $sources
if [[ -d lammps ]]; then
    echo clone of lammps exists
    cd lammps
    git checkout $branch
    git pull
else
    echo downloading
    git clone -b $branch https://github.com/lammps/lammps.git
    cd lammps
fi


# packages
cd src
make purge
make package-update


# cmake 
cd ../
if [[ -d build ]]; then
    cd build
else
    mkdir build
    cd build
fi
mkdir -p $prefix
cmake                               \
    -D CMAKE_INSTALL_PREFIX=$prefix \
    -D BUILD_EXE=yes                \
    -D BUILD_LIB=yes                \
    -D BUILD_SHARED_LIBS=yes        \
    -D BUILD_TOOL=yes               \
    ../cmake
make -j 8
make install
