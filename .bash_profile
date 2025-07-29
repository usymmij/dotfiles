#! /bin/bash
# ~/.bash_profile
#

if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi
. "$HOME/.cargo/env"

export QSYS_ROOTDIR="/home/jimmy/altera_lite/24.1std/quartus/sopc_builder/bin"
