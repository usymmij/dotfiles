#!/bin/bash

ZAFILE=$(fzf) || exit 1
if [[ $1 -eq "-k" || $1 -eq "--keep" ]]; then
    nohup zaread "$ZAFILE" > /dev/null & disown
else 
    bash $(nohup zaread "$ZAFILE" > /dev/null & disown)
fi
