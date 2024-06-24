#!/bin/bash

THEMEPATH="/home/jimmy/.config/cyclebackground/backgrounds/"
THEMES=$(ls $THEMEPATH)
CURRTHEME=$(cat /home/jimmy/.config/cyclebackground/current_background | head -n 1)

if [ ! -z "$1" ]; then
  echo "$1"
  swww img "$THEMEPATH$CURRTHEME" --transition-step 255 --transition-fps 20 
else
  NEWTHEME=""
  found=0
  # for each theme
  for theme in $THEMES; do
    # if next bg has been marked, break
    if [ $found == 2 ]; then
      break
    fi
    # mark this bg as the next one if flag set
    # then set flag to exit
    if [ $found == 1 ]; then
      NEWTHEME=$theme
      found=2
    fi
    # if current theme found, set the flag = 1
    if [ $theme == $CURRTHEME ]; then
      found=1
    fi
  done
  
  # if no background found or current is the last one
  # set the bg to the first one
  if [ $found -lt 2 ]; then
    set ${THEMES}
    NEWTHEME="$1"
  fi
  
  # set next bg
  echo $NEWTHEME > /home/jimmy/.config/cyclebackground/current_background
  swww img "$THEMEPATH$NEWTHEME" --transition-type outer --transition-pos 0.9,0.9 --transition-step 20 --transition-fps 60
  echo "previous: $CURRTHEME"
  echo "new: $NEWTHEME"
fi

