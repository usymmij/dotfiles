# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '
export PATH="/home/jimmy/.local/bin:$PATH"

eval "$(starship init bash)"

export HYPRSHOT_DIR="screenshots"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/usr/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/usr/etc/profile.d/conda.sh" ]; then
        . "/usr/etc/profile.d/conda.sh"
	elif [ -f "/opt/miniconda3/bin/conda" ]; then
		export PATH="/opt/miniconda3/bin:$PATH"
    else
        export PATH="/usr/bin:$PATH"
    fi
fi
unset __conda_setup

export CRYPTOGRAPHY_OPENSSL_NO_LEGACY=1
# <<< conda initialize <<<

# some more ls aliases
alias ll='ls -lh'
alias la='ls -A'
alias l='ls -CF'

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
fastfetch -c paleofetch.jsonc


