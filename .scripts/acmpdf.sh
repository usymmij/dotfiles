#!/bin/bash
file=$1
mv $file old-$file
pdftk A=old-$file cat A2-end output "$file"
rm old-$file
