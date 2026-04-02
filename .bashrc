# ~/.bashrc: executed by bash(1) for non-login shells. see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias la='ls -A'
alias l='ls -CF'

PS1='[\u@\h \W]\$ '

export PATH="/home/jimmy/.local/bin:$PATH"

eval "$(starship init bash)"

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# Default parameter to send to the "less" command
# -R: show ANSI colors correctly; -i: case insensitive search
LESS="-R -i"

# bind zsh-like tabbing
bind 'TAB:menu-complete'

# spicetify
export PATH=$PATH:/home/jimmy/.spicetify

# startup ommands
fastfetch -c paleofetch.jsonc 

if [ -f ~/announcement ]; then
  printf "\n\n\n"
  printf "$(cat ~/announcement)"
fi

# haskell
[ -f "/home/jimmy/.ghcup/env" ] && . "/home/jimmy/.ghcup/env" # ghcup-env

# WHEN ITS FIXED, remove this
echo "check if gtk4 tablet bug is fixed"
