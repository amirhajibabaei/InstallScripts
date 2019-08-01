prefix=$HOME/.SUPER/libxc
sources=$HOME/.SUPER/sources
cd $sources


if [[ -d libxc ]]; then
    echo clone of libxc exists
else
    echo downloading
    git clone https://gitlab.com/libxc/libxc.git
fi


cd libxc
git checkout master
git clean -f
git pull
latestTag=$(git describe --tags `git rev-list --tags --max-count=1`)
git checkout $latestTag


rm -rf objdir/
cmake -H.   -Bobjdir                        \
            -DBUILD_SHARED_LIBS=1           \
            -DENABLE_FORTRAN=1              \
            -DENABLE_FORTRAN03=1            \
            -DCMAKE_INSTALL_PREFIX=$prefix  \
&& cd objdir && make                        \
&& make -j 6                                \
&& make -j 6 test                           \
&& make -j 6 install
