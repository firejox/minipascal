#!/bin/bash
# Program :
# 	TEST
# Author : Tangent <firejox@gmail.com>
# File Name : _my_test.sh
# History :
# 	2015/06/09 Release

PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin

export PATH

if [ $# == 1 ]; then
    if [ -d "$1" ]; then
        test -e ./mpc && make clean
        make
        find $1 -name "*.pas"|xargs -n 1 -d '\n' $0
        make clean
    elif [ -f "$1" ] && [ "${1##*.}" == "pas" ]; then
        echo '==========start '$1'=============='
        ./mpc $1
        nasm -f elf -g ${1%.*}.asm -I ../lib/
        ld -m elf_i386 ${1%.*}.o ../lib/libasm.a -o ${1%.*}
        ./${1%.*}
        echo
        rm ${1%.*} ${1%.*}.o ${1%.*}.asm
        echo '==========stop '$1'==============='
    fi
elif [ $# == 0 ]; then
    $0 ./feature11_test/
fi

