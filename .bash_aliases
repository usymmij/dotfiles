alias vim='nvim'
alias evim='nvim -c "Pan"'

alias s='kitten ssh'

alias skl='cd ~/skl/sem2/'
alias sched='kitten icat ~/Documents/schedule.png'

alias ucam="fusermount -u ~/pictures/cam-mount"

alias envpip='$CONDA_PREFIX/bin/pip'
alias condac='conda activate'
alias py='python'
alias pi='python -i'
alias nvtempmax='~/.scripts/nvtempmax'

alias dim='brightnessctl s 20%'
alias bright='brightnessctl s 80%'

alias zathura='zaread'
alias za='~/.scripts/za.sh && exit'
alias cpshot='~/.scripts/cpshot.sh'
alias calc='python -i -c "import math, numpy as np"'
alias icat='kitten icat'
alias cd..='cd ..'
alias pipes='pipes.sh -f 40 -s 15 -r 5000 -p 4 -R'

alias windows='sudo bootctl set-oneshot windows.conf'
alias orca='kitten ssh -i ~/.ssh/orca jimmy@$ORCA_SSH_IP -p $ORCA_SSH_PORT'
alias ccdb='echo "enter the datacenter name (e.g. graham)" && read && ssh -i ~/.ssh/ccdb usymmij@$REPLY.computecanada.ca'

if [ -f ~/.hidden_aliases ]; then
    . ~/.hidden_aliases
fi

