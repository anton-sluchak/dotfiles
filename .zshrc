# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"



# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
# re5et
# mira
# dst
# robbyrussell
ZSH_THEME="muse"


# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

# User configuration

export PATH="/usr/local/bin:/usr/bin:/usr/sbin:/sbin:/bin"

source $ZSH/oh-my-zsh.sh

# You may need to manually set your language environment
# export LANG=en_US.UTF-8


# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

export WORKON_HOME=~/Envs

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


BOLD_RED='\033[1;31m'
NC='\033[0m' # No Color

function cd() {

  builtin cd $1

  if [[ -d ./venv ]] ; then
    . ./venv/bin/activate
    echo "${BOLD_RED}New python venv activated${NC}"

  fi

  if [[ -d ./.venv ]] ; then
    . ./.venv/bin/activate
    echo "${BOLD_RED}New python venv activated${NC}"
  fi
}

HISTFILESIZE=20000

source <(kubectl completion zsh)


# Personal environmental variables
if [[ -a ~/.zprofile ]]
then
  source ~/.zprofile
fi

source ~/dotfiles/quote.sh

# Function to commit all changes with a message and push
# Usage: yolo "Your commit message here"
yolo() {
  
  if [ -z "$1" ]; then
    quote > /dev/null
    COMMIT_MESSAGE=$(quote)
  else
    COMMIT_MESSAGE=$1
  fi
  
  # # Check if the argument is -q or a string
  # if [ "$1" = "-q" ]; then
  #   # hack for the random to work
  #   quote > /dev/null
  #   COMMIT_MESSAGE=$(quote)
  # else
  #   COMMIT_MESSAGE=$1
  # fi

  git add .
  git commit -am "$COMMIT_MESSAGE"
  git push
  
  if [ $? -eq 0 ]; then
    echo "✓ Changes committed and pushed successfully"
  else
    echo "× Something went wrong with the commit or push"
  fi

}






alias l="ls -lah"

alias s="subl ."

alias gs="git status"
alias gc="git checkout"
alias gcam="git commit -am"
alias gclean='git reset --hard && git clean -f -d'
alias gg='grep -nri --color=always'

alias ff='find . -iname'
alias focus='echo "127.0.0.1 facebook.com www.facebook.com instagram.com www.instagram.com www.youtube.com youtube.com m.youtube.com tsn.ua" | sudo tee -a /etc/hosts'

alias zsh86='arch -x86_64 zsh'

alias penv='source .venv/bin/activate'
alias pyreset='rm -rf .venv && python3.11 -m venv .venv && penv'

alias k='kubectl'
alias kc='kubectl config'

alias tf='terraform'

alias sshkey='pbcopy < ~/.ssh/id_rsa.pub && echo "Public ssh key is copied to clipboard"'
