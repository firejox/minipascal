#!/bin/bash
# Program :
# 	TEST
# Author : Tangent <firejox@gmail.com>
# File Name : __test.sh
# History :
# 	2015/06/10 Release

PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin

export PATH

if [ $# == 1 ]; then
    ../mpc -pt $1 ${1%.*}'_1'
    ../mpc $1 ${1%.*}'_1'
    ../mpc -c $1 ${1%.*}'_1'
    ../mpc -a $1 ${1%.*}'_1'

    ../standard_mpc -pt $1 ${1%.*}'_2'
    ../standard_mpc $1 ${1%.*}'_2'
    ../standard_mpc -c $1 ${1%.*}'_2'
    ../standard_mpc -a $1 ${1%.*}'_2'

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
fi

