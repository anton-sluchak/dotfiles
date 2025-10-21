alias l="ls -lah"

alias s="subl ."
alias c="code ."
alias i="idea ."

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
