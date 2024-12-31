# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific aliases and functions
PS1='\[\033[01;34m\]\u@\h\[\033[00m\]:\[\033[01;38m\]\w\[\033[00m\]\$ '
#PS1='$ '

## Colorize the ls output ##
alias ls='ls --color=auto'

alias \
shrc="nano ~/.bashrc"

lss () {
  du -hc "$1" | sort -rh | head -20
}
unset HISTFILE
