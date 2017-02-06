export CDPATH=~/dev/work/sequoia:~/dev/work/sequoia/foundations:~/dev/work/sequoia/core

########################
#     Load Scripts     #
########################

if [[ -s "$HOME/.profile" ]]; then
    source "$HOME/.profile" # Load the default .profile
fi

if [[ -s ~/.bash_profile_work ]]; then
    source ~/.bash_profile_work
fi

if [[ -s "$HOME/.rvm/scripts/rvm" ]]; then
    source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
fi

########################
#        Paths         #
########################

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
export PATH="/usr/java/jre1.8.0_92/bin:$PATH" # Add JRE to PATH
export PATH="$HOME/.cabal/bin:/opt/cabal/1.22/bin:/opt/ghc/7.10.3/bin:$PATH"
export PATH=~/.cabal/bin:/opt/cabal/1.22/bin:/opt/ghc/7.10.3/bin:$PATH

export JAVA_HOME=/usr/java/jre1.8.0_92/bin


