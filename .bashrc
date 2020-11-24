alias bashrc='vim ~/.bashrc'
alias reload='source ~/.bashrc'

alias ..='cd ..'
alias ll='ls -al'
alias cl='clear'

alias g='git'
alias gs='git ss'
alias gss='git ss'

alias gitsync='branch=$(git branch | sed -n -e "s/^\* \(.*\)/\1/p");git stash;git co integration;git p -r;git co $branch;git sta pop;'

alias remove_EOF_newline='truncate -s -1'

alias plugin='cd /e/work/VAST2/plugins'
alias qml='cd /e/work/VAST2/VAST2'
alias uat='cd /e/work/VAST2/UAT'
alias viewcell='cd /e/work/VAST2/ViewCellQml'
