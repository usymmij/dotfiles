#!/bin/bash

dir=$(dirname $1)
if [[ ${1: -1} == "/" ]]; then
    dir=$1
fi
if ! [ -d $dir ]; then
    mkdir -p $dir
fi

lastfile=$(ls ~/$HYPRSHOT_DIR| tail -1)
cp ~/$HYPRSHOT_DIR/$lastfile $1
echo "$1" > /tmp/cpshot_last_write_path
echo "$lastfile" >> /tmp/cpshot_last_write_path

