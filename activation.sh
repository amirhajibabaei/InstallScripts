THIS="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

if [[ -d $THIS/bin ]]; then
    export PATH=$THIS/bin:$PATH
fi

if [[ -d $THIS/lib ]]; then
    export LD_LIBRARY_PATH=$THIS/lib:$LD_LIBRARY_PATH
fi

if [[ -d $THIS/lib64 ]]; then
    export LD_LIBRARY_PATH=$THIS/lib64:$LD_LIBRARY_PATH
fi

if [[ -d $THIS/include ]]; then
    export C_INCLUDE_PATH=$THIS/include:$C_INCLUDE_PATH
fi
