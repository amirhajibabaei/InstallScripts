cc=gcc
fc=gfortran
prefix=$HOME/.SUPER/numerical
sources=$HOME/.SUPER/sources
cd $sources


if [[ -d OpenBLAS ]]; then
    echo clone of OpenBLAS exists
else
    echo downloading
    #git clone https://gitlab.com/OpenBLAS/OpenBLAS.git
    git clone https://github.com/xianyi/OpenBLAS.git
fi


cd OpenBLAS
git checkout master
git clean -f
git pull
latestTag=$(git describe --tags `git rev-list --tags --max-count=1`)
git checkout $latestTag


#make clean                     # fresh install?
make CC=$cc FC=$fc
make PREFIX=$prefix install
