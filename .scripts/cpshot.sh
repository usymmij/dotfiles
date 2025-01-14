#!/bin/bash
#
lastfile=$(ls ~/$HYPRSHOT_DIR| tail -1)
cp ~/$HYPRSHOT_DIR/$lastfile ./$1
echo "$lastfile"
