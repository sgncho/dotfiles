# bash history
HISTCONTROL=ignoreboth:erasedups
HISTSIZE=1000
HISTFILESIZE=2000

# prompt
PS1="\[\e[1;32m\]\h\[\e[0m\] \[\e[1;34m\]\w\[\e[0m\]
$ "

# default alias
alias ll="ls -alF"
alias la="ls -A"
alias vi="vim"
alias catp="cat"
alias grep="grep --color=auto"

# source .bashrc.d
if [ -d "$HOME/.bashrc.d" ]; then
    for script in "$HOME/.bashrc.d/"*; do
        [ -f "$script" ] && [ -r "$script" ] && . "$script"
    done
fi

