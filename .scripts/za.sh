#!/bin/bash

ZAFILE=$(fzf) || exit 1
nohup zaread "$ZAFILE" > /dev/null & disown
