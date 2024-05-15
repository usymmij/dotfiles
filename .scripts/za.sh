#!/bin/bash

ZAFILE=$(fzf)

nohup zaread $ZAFILE & disown > /dev/null


