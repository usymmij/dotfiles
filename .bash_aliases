alias vim='nvim'
alias evim='nvim -c "Pan"'
alias s='kitty +kitten ssh'
alias zathura='zaread'
alias skl='cd ~/skl/sem2/'
alias ard='arduino-cli'
alias condac='conda activate'
alias dim='brightnessctl s 20%'
alias bright='brightnessctl s 80%'
alias sched='kitten icat ~/Documents/schedule.png'
alias vinds='kitten icat ~/Documents/vim.png'
alias cpshot='/home/jimmy/.scripts/cpshot.sh'
alias clock='tty-clock'
alias calc='python -i -c "import math, numpy as np"'
alias sudolock='faillock --reset'
alias envpip='$CONDA_PREFIX/bin/pip'
alias get_idf='. $HOME/code/esp-idf/export.sh'
alias z='zoxide'
alias kvim='nvim ~/agenda.md -c "KanbanOpen ~/agenda.md"'
alias windows='sudo bootctl set-oneshot windows.conf'

if [ -f ~/.hidden_aliases ]; then
    . ~/.hidden_aliases
fi

