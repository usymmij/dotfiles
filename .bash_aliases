alias vim='nvim'
alias evim='nvim -c "Pan"'
alias tags='printf "\33[0;31mFIX\n\33[0;34mTODO\nNOTE\n\33[0;33mHACK\nWARN\n\33[1;37mPERF\nTEST"'
alias nts='returnpath=$(pwd);cd ~/notes; nvim -c Pan && cd $returnpath'

alias ucam="fusermount -u /mnt/cam"
alias lcam="gphoto2 --auto-detect"

alias ur='uv run'
alias up='uv run python'

alias zathura='zaread'
alias za='~/.scripts/za.sh && exit'
alias splitpdf='~/.scripts/splitpdf.sh'
alias watchfile='~/.scripts/watchfile.sh'
alias cpshot='~/.scripts/cpshot.sh'
alias timer='~/.scripts/sleeptimer.sh'

alias calc='python -i ~/.scripts/calc.py'
alias icat='kitten icat'
alias cd..='cd ..'
alias cdl="cd \$(ls | tail -1)"

alias windows='sudo bootctl set-oneshot windows.conf'
alias wreboot='windows && reboot'
alias ssh='kitten ssh'
alias ccdb='echo "enter the datacenter name (e.g. graham)" && read && kitten ssh -i ~/.ssh/ccdb usymmij@$REPLY.alliancecan.ca'

alias hyprconf='vim ~/.config/hypr/hyprland.lua'
alias localconf='vim ~/.config/hypr/local.conf'
alias lockconf='vim ~/.config/hypr/hyprlock.conf'
alias idleconf='vim ~/.config/hypr/hypridle.conf'
alias paperconf='vim ~/.config/hypr/hyprpaper.conf'

if [ -f ~/.hidden_aliases ]; then
    . ~/.hidden_aliases
fi
