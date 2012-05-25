. ~/.profile

shopt -s histappend
shopt -s checkwinsize

unset MAILCHECK

bold="\[\033[1m\]"
off="\[\033[m\]"
export PS1="\a\h:$bold\w$off \$ "

if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*