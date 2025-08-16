#!/bin/bash
file=$1
st=1
chapter=1

shift # remove first arg from $@

for i in $@; do
    printf "chapter $chapter: pages $st-$i\n"
    pdftk A=$file cat A$st-$i output "chapter$chapter.pdf"
    chapter=$(($chapter + 1))
    st=$(($i+1))
done

printf "chapter $chapter: pages $st+\n"
pdftk A=$file cat A$st-end output "chapter$chapter.pdf"
