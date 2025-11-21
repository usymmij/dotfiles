alias vim='nvim'
alias evim='nvim -c "Pan"'
alias tags='printf "\33[0;31mFIX\n\33[0;34mTODO\nNOTE\n\33[0;33mHACK\nWARN\n\33[1;37mPERF\nTEST"'

alias s='kitten ssh'

alias skl='cd ~/notes/courses/'
alias nts='returnpath=$(pwd);cd ~/notes; nvim -c Pan && cd $returnpath'
alias sc='cd ~/scratch'

alias ucam="fusermount -u /mnt/cam"
alias lcam="gphoto2 --auto-detect"

alias envpip='$CONDA_PREFIX/bin/pip'
alias condac='condar; conda activate'
alias condal='condar; conda env list'
alias py='python'
alias ur='uv run'
alias up='uv run python'
alias pi='python -i'
alias nvtempmax='~/.scripts/nvtempmax'
alias socker='sudo docker'

alias dim='brightnessctl s 20%'
alias bright='brightnessctl s 80%'

alias zathura='zaread'
alias za='~/.scripts/za.sh && exit'
alias splitpdf='~/.scripts/splitpdf.sh'
alias watchfile='~/.scripts/watchfile.sh'
alias cpshot='~/.scripts/cpshot.sh'
alias calc='python -i ~/.scripts/calc.py'
alias icat='kitten icat'
alias cd..='cd ..'
alias pipes='pipes.sh -f 40 -s 15 -r 5000 -p 4 -R'

alias windows='sudo bootctl set-oneshot windows.conf'
alias wreboot='windows && reboot'
alias orca='kitten ssh -i ~/.ssh/orca -p $ORCA_SSH_PORT jimmy@$ORCA_SSH_IP'
alias turtle='kitten ssh 192.168.1.80'
alias ccdb='echo "enter the datacenter name (e.g. graham)" && read && kitten ssh -i ~/.ssh/ccdb usymmij@$REPLY.alliancecan.ca'

alias hyprconf='vim ~/.config/hypr/hyprland.conf'
alias lockconf='vim ~/.config/hypr/hyprlock.conf'
alias idleconf='vim ~/.config/hypr/hypridle.conf'
alias paperconf='vim ~/.config/hypr/hyprpaper.conf'
if [ -f ~/.hidden_aliases ]; then
    . ~/.hidden_aliases
fi

