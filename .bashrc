# Bash Environment
# Copyright 2013 Michael D'Agosta <mdagosta@codebug.com>

if [[ -n $SUDO_USER ]]; then
  export HOME="/home/$SUDO_USER";
elif [[ -n $(uname -a |grep Darwin) ]]; then
  export HOME="/Users/$USER"
else
  export HOME="/home/$USER"
fi
. $HOME/.bash_completion_git
export PS1='$(__git_ps1 "(%s) ")\u@\h:\w> '
export TERM="xterm"
export LANG="en_US.UTF-8"
#export LC_ALL="C"
export EDITOR="emacs -nw"
export PYTHONPATH="$HOME/src"
export PYTHONDONTWRITEBYTECODE=1


# Prepend directories to PATH if they aren't already in it
for dir in $HOME/bin /bin /usr/bin /usr/local/bin /sbin /usr/sbin /usr/local/sbin; do
  if ! echo $PATH | /usr/bin/env grep -q "$dir" ; then PATH=$PATH:$dir; fi
done
export PATH=$PATH


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
alias va='. virtualenv/bin/activate'
alias mirror='rsync -azvP --stats "$1" "$2"'

alias gitu='git pull'
alias gitd='git diff --color'
alias gitp='git push'
alias gitpt='git push --tags'
alias gits='git status'
alias gitc='git commit -a -m '
alias gitup='git pull && git push'

alias apt-init='sudo apt-get update && sudo apt-get upgrade && sudo apt-get install xmonad emacs emacs-goodies-el mysql-server python-dev python-django-debug-toolbar ack-grep tig curl nmap aterm apache2 php5 php5-cli php5-mysql php5-curl libxss1 muse-el keychain python-mode git nginx python-pip python-setuptools libmysqlclient-dev python-reportlab python-reportlab-accel python-renderpm rxvt-unicode && sudo apt-get clean'
alias apt-init-nox='sudo apt-get update && sudo apt-get upgrade && sudo apt-get install emacs emacs-goodies-el mysql-server python-dev python-django-debug-toolbar ack-grep tig curl nmap apache2 php5 php5-cli php5-mysql php5-curl libxss1 muse-el python-mode git nginx python-pip python-setuptools libmysqlclient-dev python-reportlab python-reportlab-accel python-renderpm && sudo apt-get clean'
alias apt-init-lite='sudo apt-get update && sudo apt-get upgrade && sudo apt-get install emacs emacs-goodies-el python-dev ack-grep tig curl nmap libxss1 muse-el keychain python-mode git python-pip python-setuptools libmysqlclient-dev && sudo apt-get clean' 
# Prevent IPs from dropping on some networks, and don't use NetworkManager
alias apt-clean='sudo apt-get remove resolvconf; sudo apt-get purge network-manager; sudo apt-get clean'

# pkgs() authored by Pete Hicks
pkgs () {
  if [[ ! -z $1 ]]
  then
    dpkg -l "*$1*" | grep \^[hi]i | tr -s " " | grep $1
  fi
}


# Load host-specific environment
if [ -e $HOME/.bashrc_$HOSTNAME ]; then
    . $HOME/.bashrc_$HOSTNAME
fi


# Run keychain if installed
if [[ -x $(which keychain) && -z $SUDO_USER ]]; then
  eval $(keychain --eval id_rsa)
fi
