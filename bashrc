# Bash initialization for interactive non-login shells and
# for remote shells (info "(bash) Bash Startup Files").

# Export 'SHELL' to child processes.  Programs such as 'screen'
# honor it and otherwise use /bin/sh.
export SHELL

if [[ $- != *i* ]]
then
    # We are being invoked from a non-interactive shell.  If this
    # is an SSH session (as in "ssh host command"), source
    # /etc/profile so we get PATH and other essential variables.
    [[ -n "$SSH_CLIENT" ]] && source /etc/profile

    # Don't do anything else.
    return
fi

export XDG_CONFIG_HOME=$HOME/.config
export PATH="$PATH:$HOME/go/bin/"
# Source the system-wide file.
source /etc/bashrc

# Adjust the prompt depending on whether we're in 'guix environment'.
if [ -n "$GUIX_ENVIRONMENT" ]
then
    PS1='\u@\h \w [env]\$ '
else
    PS1='\u@\h \w\$ '
fi
alias ls='ls -p --color=auto'
alias l='ls -l'
alias grep='grep --color=auto'
alias goi='env C_INCLUDE_PATH=$HOME/.guix-profile/include  LIBRARY_PATH=$HOME/.guix-profile/lib go install'
alias gor='env C_INCLUDE_PATH=$HOME/.guix-profile/include  LIBRARY_PATH=$HOME/.guix-profile/lib go run'
alias em='emacs-28.0.50'
alias tunnel='ssh -R 80:localhost:3000 nokey@localhost.run'
# xcape -e 'Control_L=BackSpace'
