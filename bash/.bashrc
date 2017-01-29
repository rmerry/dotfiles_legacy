# Exit if shell is not running interactively, 
case $- in
    *i*) ;;
    *) return;;
esac

########################
#   Global Variables   #
########################

COLOUR_RED="\033[0;31m"
COLOUR_YELLOW="\033[0;33m"
COLOUR_GREEN="\033[0;32m"
COLOUR_BLUE="\033[0;34m"
COLOUR_LIGHT_RED="\033[1;31m"
COLOUR_LIGHT_GREEN="\033[1;32m"
COLOUR_WHITE="\033[1;37m"
COLOUR_LIGHT_GRAY="\033[0;37m"
COLOUR_NONE="\e[0m"

########################
# Function Definitions #
########################

# Get the git branch name
gitBranchName() {
    branch_name="$(git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/')"

    if [[ -n $branch_name ]]; then

        status="$(git status 2> /dev/null)"

        # Set color based on clean/staged/dirty.
        if [[ ${status} =~ "working directory clean" ]]; then
            strcolour="$COLOUR_GREEN"
        elif [[ ${status} =~ "Changes to be committed" ]]; then
            strcolour="$COLOUR_LIGHT_RED"
        else
            strcolour="$COLOUR_YELLOW"
        fi

        echo -e "$strcolour$branch_name$COLOUR_NONE"
    else
        echo ""
    fi
}

########################
#     Core Config      #
########################

HISTCONTROL=ignoreboth # No duplicates of lines ending in a space (in the history file)
HISTFILESIZE=100000

export EDITOR=vim

shopt -s checkwinsize # Check the win size after each command and update the values of LINES and COLUMNS
shopt -s extglob # Globbing Options (extended globs [extglob])
#shopt -s globstar # The '**' glob matches all files and zero or more [sub]directories
shopt -s histappend # Append to the history file, don't overwrite it

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
rxvt*|xterm*|*-256color)
    PS1="\[\033[01;32m\]\u\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$(gitBranchName) \$ "
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

########################
#        Paths         #
########################

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
export PATH="/usr/java/jre1.8.0_92/bin:$PATH" # Add JRE to PATH
export JAVA_HOME=/usr/java/jre1.8.0_92/bin

source "$HOME/.homesick/repos/homeshick/homeshick.sh"
export PATH="$HOME/.cabal/bin:/opt/cabal/1.22/bin:/opt/ghc/7.10.3/bin:$PATH"
export PATH=~/.cabal/bin:/opt/cabal/1.22/bin:/opt/ghc/7.10.3/bin:$PATH
