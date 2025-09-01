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

# spicetify
export PATH=$PATH:/home/jimmy/.spicetify

# startup commands
if [ $SSH_TTY ] 
then
  fastfetch -c paleofetch.jsonc
else
  fastfetch -c paleofetch.jsonc --kitty-direct "~/.config/fastfetch.png" --logo-width 30
fi

if [ -f ~/announcement ]; then
  printf "\n\n\n"
  printf "$(cat ~/announcement)"
fi

[ -f "/home/jimmy/.ghcup/env" ] && . "/home/jimmy/.ghcup/env" # ghcup-env

# CARLA
export UE4_ROOT="~/code/UnrealEngine/"

# conda takes forever to load, so instead of running it for each terminal 
# run `condar` before using conda activate
condasetup () {
# if conda isn't working, run conda init and this will be overwritten
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/opt/miniconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/opt/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/opt/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/opt/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<
export CRYPTOGRAPHY_OPENSSL_NO_LEGACY=1
}
conda_ready=0
condar() {
    if [ $conda_ready -eq 0 ]; then
        condasetup
        conda_ready=1
    fi
}
. "$HOME/.cargo/env"

export QSYS_ROOTDIR="/home/jimmy/altera_lite/24.1std/quartus/sopc_builder/bin"

# keep until we finish the backup script
zfs list -t snapshot
