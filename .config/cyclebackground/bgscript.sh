#!/bin/bash

THEMEPATH="/home/$USER/.config/cyclebackground/backgrounds/"
THEMES=$(ls $THEMEPATH)
if [[ -f /tmp/current_background ]];  then
    CURRTHEME=$(cat /tmp/current_background | head -n 1)
else
    CURRTHEME=$(cat ~/.config/cyclebackground/current_background | head -n 1)
fi

if [ ! -z "$1" ]; then
  echo "$1"
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
    if [[ $theme == $CURRTHEME ]]; then
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
  echo $NEWTHEME > /tmp/current_background

  hyprctl hyprpaper wallpaper ", $THEMEPATH$NEWTHEME"

  echo "previous: $CURRTHEME"
  echo "new: $NEWTHEME"
fi

