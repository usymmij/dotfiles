#!/bin/bash
file=$1
st=1
chapter=1

shift # remove first arg from $@

for i in $@; do
    end=$(($i-1))
    printf "chapter $chapter: pages $st-$end\n"
    pdftk A=$file cat A$st-$end output "chapter$chapter.pdf"
    chapter=$(($chapter + 1))
    st=$(($i))
done

printf "chapter $chapter: pages $st+\n"
pdftk A=$file cat A$st-end output "chapter$chapter.pdf"
