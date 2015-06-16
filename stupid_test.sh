#!/bin/bash
# Program :
#  FEATURE TEST
# Author : Tangent <firejox@gmail.com>
# File Name : stupid_test.sh
# History :
# 	2015/06/10 Release



if [ $# == 1 ]; then
    if [ -d "$1" ]; then
        test -e ./mpc && make clean
        make
        find $1 -name "*.pas"|xargs -n 1 -d '\n' $0
        make clean
    elif [ -f "$1" ] && [ "${1##*.}" == "pas" ]; then
        echo '==========start '$1' =============='
        ./mpc -pt $1 ${1%.*}'_1'
        ./mpc $1 ${1%.*}'_1'
        ./mpc -c $1 ${1%.*}'_1'
        ./mpc -a $1 ${1%.*}'_1'

        ./standard_mpc -pt $1 ${1%.*}'_2'
        ./standard_mpc $1 ${1%.*}'_2'
        ./standard_mpc -c $1 ${1%.*}'_2'
        ./standard_mpc -a $1 ${1%.*}'_2'

        echo 'spim check'
        diff -c ${1%.*}'_1' ${1%.*}'_2'
        rm ${1%.*}'_1' ${1%.*}'_2'
        echo 'parse check'
        diff -c ${1%.*}'_1.parse' ${1%.*}'_2.parse'
        rm ${1%.*}'_1.parse' ${1%.*}'_2.parse'
        echo 'token check'
        diff -c ${1%.*}'_1.token' ${1%.*}'_2.token'
        rm  ${1%.*}'_1.token' ${1%.*}'_2.token'
        echo 'check check'
        diff -c ${1%.*}'_1.check' ${1%.*}'_2.check'
        rm  ${1%.*}'_1.check' ${1%.*}'_2.check'
        echo 'alloc check'
        diff -c ${1%.*}'_1.alloc' ${1%.*}'_2.alloc'
        rm  ${1%.*}'_1.alloc' ${1%.*}'_2.alloc'

        echo '==========stop '$1' ==============='
    fi
elif [ $# == 0 ]; then
    $0 ./feature_test/
else 
    echo 'Too much argument!'
fi

