# .bashrc

# Source global definitions
if [ -f /etc/bash.bashrc ]; then
	. /etc/bash.bashrc
fi

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

HISTCONTROL=ignoredups:erasedups  # no duplicate entries
HISTSIZE=500000                   # big big history
HISTFILESIZE=500000               # big big history
shopt -s histappend                      # append to history, don't overwrite it

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# Save and reload the history after each command finishes
export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"

# User specific aliases and functions
alias calc="gnome-calculator"
alias :q="exit"

alias clear='printf "\033c"'

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# Source airlined shell prompt if exist
[ -f ~/.shell_prompt ] && source ~/.shell_prompt || true

#Add all non-default keys to ssh-agent if there is only one key
agent_keys="$(ssh-add -l | wc -l)"
keys=( $(find ~/.ssh -maxdepth 1 -type f | grep -v "config\|authorized_keys\|.pub\|id_rsa\|known_hosts") )
[ $agent_keys -le ${#keys[@]} ] &&  for i in ${keys[@]}; do ssh-add "$i" > /dev/null 2>&1; done

