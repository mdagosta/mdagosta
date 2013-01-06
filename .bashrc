# Bash Environment
# Copyright 2013 Michael D'Agosta <mdagosta@codebug.com>

export PS1='\u@\h:\w> '
export TERM="xterm"
export LANG="en_US"
export LC_ALL="C"
export HOME="/home/$USER"
export EDITOR="emacs -nw"
export PYTHONPATH="$HOME/src"
export PYTHONDONTWRITEBYTECODE=1


# Prepend directories to PATH if they aren't already in it
for dir in $HOME/bin /bin /usr/bin /usr/local/bin /sbin /usr/sbin /usr/local/sbin; do
  if ! echo $PATH | /usr/bin/env grep -q "$dir" ; then PATH=$PATH:$dir; fi
done
export PATH=$PATH


# Link .bash_profile
if [ ! -L ~/.bash_profile ]; then
  ln -s ~/.bashrc ~/.bash_profile
fi


# Run keychain if installed
if [[ -x $(which keychain) && -z $SUDO_USER ]]; then
  eval $(keychain --eval id_rsa)
fi


# Set up terminal coloring
xrdb -merge $HOME/.Xresources


# Aliases
alias ls='ls -F'
alias la='ls -a'
alias lr='ll -R'
alias ll='ls -la'
alias l='ls -l'

alias ds='dirs -v'
alias p='pushd'
alias pp='popd'
alias dk='du -sk * |sort -n'
alias e='emacs -nw'

alias gitu='git pull'
alias gitd='git diff --color'
alias gitp='git push'
alias gitpt='git push --tags'
alias gits='git status'
alias gitc='git commit -a -m '
alias gitup='git pull && git push'


# Load host-specific environment
if [ -e .bashrc_$HOSTNAME ]; then
    . .bashrc_$HOSTNAME
fi
