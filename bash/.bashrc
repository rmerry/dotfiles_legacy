# Exit if shell is not running interactively$()
case $- in
    *i*) ;;
    *) return;;
esac

########################
#   Global Variables   #
########################

COLOUR_RED="\e[0;31m"
COLOUR_YELLOW="\e[0;33m"
COLOUR_GREEN="\e[0;32m"
COLOUR_BLUE="\e[0;34m"
COLOUR_LIGHT_RED="\e[1;31m"
COLOUR_LIGHT_GREEN="\e[1;32m"
COLOUR_WHITE="\e[1;37m"
COLOUR_LIGHT_GRAY="\e[0;37m"
COLOUR_NONE="\e[0m"

# COLOUR_BLACK=$(tput setaf 0)
# COLOUR_RED=$(tput setaf 1)
# COLOUR_GREEN=$(tput setaf 2)
# COLOUR_YELLOW=$(tput setaf 3)
# COLOUR_LIME_YELLOW=$(tput setaf 190)
# COLOUR_POWDER_BLUE=$(tput setaf 153)
# COLOUR_BLUE=$(tput setaf 4)
# COLOUR_MAGENTA=$(tput setaf 5)
# COLOUR_CYAN=$(tput setaf 6)
# COLOUR_WHITE=$(tput setaf 7)
# COLOUR_BRIGHT=$(tput bold)
# COLOUR_NORMAL=$(tput sgr0)
# COLOUR_BLINK=$(tput blink)
# COLOUR_REVERSE=$(tput smso)
# COLOUR_UNDERLINE=$(tput smul)

########################
# Function Definitions #
########################

# Get the git branch name
gitBranchName() {
    branch_name="$(git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/')"

    if [[ -n $branch_name ]]; then
        echo -n $branch_name
    fi
}

gitBranchColour() {
    branch_name="$(git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/')"

    if [[ -n $branch_name ]]; then

        status="$(git status 2> /dev/null)"

        # Set color based on clean/staged/dirty.
        if [[ ${status} =~ "working directory clean" ]]; then
            strcolour=$COLOUR_GREEN
        elif [[ ${status} =~ "Changes to be committed" ]]; then
            strcolour=$COLOUR_LIGHT_RED
        else
            strcolour=$COLOUR_YELLOW
        fi

        echo -e -n $strcolour
    else
        return 1
    fi
}

########################
#     Core Config      #
########################

HISTCONTROL=ignoreboth # No duplicates of lines ending in a space (in the history file)
HISTSIZE=100000
HISTFILESIZE=$HISTSIZE

export EDITOR=vim

shopt -s checkwinsize # Check the win size after each command and update the values of LINES and COLUMNS
shopt -s extglob # Globbing Options (extended globs [extglob])
#shopt -s globstar # The '**' glob matches all files and zero or more [sub]directories
shopt -s histappend # Append to the history file, don't overwrite it

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
rxvt*|xterm*|*-256color)
    # PS1="\[\033[01;32m\]\u\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$(gitBranchName) \$ "
    #
    # Had lots of problems with incorporating the git branch name; the important point is
    # to wrap the variables in \[ \] blocks -- this tells bash that this is a non text 
    # entry and therefore it will not count the string in the columns & rows calculation
    PS1="\[\e[01;32m\]\u\[\e[0m\]:\[\e[01;34m\]\w \[\$(gitBranchColour)\]\[\$(gitBranchName)\]\[\e[0m\] \$ "
    # PS1='\[\e[01;32m\]\u\[\e[0m\]:\[\e[01;34m\]\w\[\e[0m\] \[\$(gitBranchName)\]\[\e[0m\] \$ '
    ;;
*)
    PS1="\u:\w \[$txtcyn\]\$(gitBranchName) \$ "
    ;;
esac

########################
#       Aliases        #
########################

# Read in an alias config (if one exists)
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

alias tmux='tmux -2' # Start in 256 colour mode
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias vi='vim'

# Enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='grep -E --color=auto'
fi

# git aliases
alias lg='git log --color --graph --pretty=format:%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset --abbrev-commit'
alias rpull='git pull --rebase'

# Development
alias ngrep='grep -Ern --exclude-dir=node_modules --exclude-dir=logs --exclude=\*.xml --exclude=\*.html --exclude=\*.js.map --exclude=\bundle.js --exclude=\app.*.js'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
    if [ -f /usr/share/bash-completion/bash_completion ]; then
        . /usr/share/bash-completion/bash_completion
    elif [ -f /etc/bash_completion ]; then
        . /etc/bash_completion
    fi
fi

