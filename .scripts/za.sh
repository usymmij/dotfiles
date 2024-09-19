#!/bin/bash

ZAFILE=$(fzf)

nohup zaread "$ZAFILE" > /dev/null & disown


