alias vim='nvim'
alias evim='nvim -c "Pan"'

alias s='kitten ssh'

alias skl='cd ~/skl/sem2/'
alias sched='kitten icat ~/Documents/schedule.png'

alias envpip='$CONDA_PREFIX/bin/pip'
alias condac='conda activate'
alias py='python'
alias pi='python -i'

alias dim='brightnessctl s 20%'
alias bright='brightnessctl s 80%'

alias zathura='zaread'
alias cpshot='/home/jimmy/.scripts/cpshot.sh'
alias calc='python -i -c "import math, numpy as np"'
alias icat='kitten icat'
alias cd..='cd ..'

alias windows='sudo bootctl set-oneshot windows.conf'
alias orca='kitten ssh -i ~/.ssh/orca jimmy@$ORCA_SSH_IP -p $ORCA_SSH_PORT'

if [ -f ~/.hidden_aliases ]; then
    . ~/.hidden_aliases
fi

