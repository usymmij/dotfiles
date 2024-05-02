#! /bin/bash
# ~/.bash_profile
#
export PATH=$PATH:/home/jimmy/.spicetify

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
