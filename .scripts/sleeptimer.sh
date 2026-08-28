#!/bin/bash

hours=0
minutes=0
seconds=0

while getopts "h:m:s:" opt; do
    case $opt in
        h) hours=$OPTARG ;;
        m) minutes=$OPTARG ;;
        s) seconds=$OPTARG ;;
        *) echo "Usage: $0 [-h hours] [-m minutes] [-s seconds]"; exit 1 ;;
    esac
done

total_seconds=$(( hours * 3600 + minutes * 60 + seconds ))


start_time=$(date +%s)
end_time=$(( start_time + total_seconds ))

tput civis
clear
while true; do
    now=$(date +%s)
    remaining=$(( end_time - now ))

    if [ "$remaining" -lt 0 ]; then
        break
    fi

    cols=$(tput cols)
    lines=$(tput lines)
    row=$(( lines / 2 ))
    col=$(( (cols - 24) / 2 ))
    tput cup "$row" "$col"
    printf "Time remaining: %02d:%02d:%02d" $(( remaining / 3600 )) $(( (remaining % 3600) / 60 )) $(( remaining % 60 ))

    sleep 1
done
tput cnorm

while [ true ]; do paplay /usr/share/sounds/freedesktop/stereo/bell.oga && sleep 0.5; done
