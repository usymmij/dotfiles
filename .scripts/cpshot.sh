#!/bin/bash
#
lastfile=$(ls ~/screenshots | tail -1)
cp ~/screenshots/$lastfile ./$1
echo "$lastfile"
