#!/bin/bash

dir=$(dirname $1)
if [[ ${1: -1} == "/" ]]; then
    dir=$1
fi
if ! [ -d $dir ]; then
    mkdir -p $dir
fi

lastfile=$(ls -t ~/screenshots/ | head -1)
cp ~/screenshots/$lastfile $1
echo "$1" > /tmp/cpshot_last_write_path
echo "$lastfile" >> /tmp/cpshot_last_write_path

