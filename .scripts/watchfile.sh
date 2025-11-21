#!/bin/bash

command=$1
lastupdated=0
for file in ${@:2}; do 
    filedate=$(stat -c %Y $file)
    if [ $filedate -gt $lastupdated ]; then
        lastupdated=$(stat -c %Y $file)
    fi 
done


while [ 1 ]; do
    sleep 0.5
    for file in ${@:2}; do 
        filedate=$(stat -c %Y $file)
        if [ $filedate -gt $lastupdated ]; then
            lastupdated=$(stat -c %Y $file)
            eval $command
        fi 
    done
done
