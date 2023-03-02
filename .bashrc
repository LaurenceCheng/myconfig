# User specific environment
PATH="$HOME/.local/bin:$HOME/bin:$PATH"
export PATH

            RED="\[\033[01;31m\]"
          GREEN="\[\033[01;32m\]"
         YELLOW="\[\033[01;33m\]"
           BLUE="\[\033[01;34m\]"
         PURPLE="\[\033[01;35m\]"
           CYAN="\[\033[01;36m\]"
     COLOR_NONE="\[\e[00m\]"

# Determine active Python virtualenv details.
function set_virtualenv () {
  if test -z "$VIRTUAL_ENV" ; then
      PYTHON_VIRTUALENV=""
  else
      PYTHON_VIRTUALENV="${BLUE}[`basename \"$VIRTUAL_ENV\"`]${COLOR_NONE} "
  fi
}

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=
function parse_git_branch() {
     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

function gh_pr_number() {
    number=$(gh pr status --jq ".currentBranch.number" --json number 2> /dev/null)
    [ -z "$number" ] || echo "(PR-$number)"
}

function gh_pr_state() {
    state=$(gh pr status --jq ".currentBranch.state" --json state 2> /dev/null)
    [ -z "$state" ] || echo " - $state"
}

function glab_pr_number() {
    [ -d ".git" ] && number=$(glab mr view | sed -n '8p' | sed 's/^.*:[[:space:]]*//' 2> /dev/null)
    [ -z "$number" ] || echo " - $number"
}

function glab_pr_state() {
    [ -d ".git" ] && state=$(glab mr view | sed -n '2p' | sed 's/^.*:[[:space:]]*//' 2> /dev/null)
    [ -z "$state" ] || echo " - $state"
}

# Set the full bash prompt.
function set_bash_prompt () {
  # Set the PROMPT_SYMBOL variable. We do this first so we don't lose the
  # return value of the last command.
  #set_prompt_symbol $?

  # Set the PYTHON_VIRTUALENV variable.
  set_virtualenv

  # Set the BRANCH variable.
  #set_git_branch

  # Set the bash prompt variable.
  #PS1="
#${PYTHON_VIRTUALENV}${GREEN}\u@\h${COLOR_NONE}:${YELLOW}\w${COLOR_NONE}${BRANCH}
#${PROMPT_SYMBOL} "

PS1="${PYTHON_VIRTUALENV}${debian_chroot:+($debian_chroot)}${GREEN}\u@\h${COLOR_NONE}:${YELLOW}\w${CYAN} $(parse_git_branch)${RED}$(gh_pr_number)${PURPLE}$(gh_pr_state)${COLOR_NONE}\n$ "
}

PROMPT_COMMAND=set_bash_prompt

# User specific aliases and functions
alias bashrc='vim ~/.bashrc'
alias reload='source ~/.bashrc'

alias ..='cd ..'
alias ll='ls -al'
alias cl='clear'

alias g='git'
alias g='git'
if [ -f ~/.git-completion.bash ]; then
    source ~/.git-completion.bash
else
    wget https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash
    mv git-completion.bash .git-completion.bash
    source ~/.git-completion.bash
fi
__git_complete g __git_main

alias gs='git ss'
alias gss='git ss'

alias gitsync='branch=$(git branch | sed -n -e "s/^\* \(.*\)/\1/p");git stash;git co integration;git p -r;git co $branch;git sta pop;'
alias gitrmbr='branch=$(git branch | sed -n -e "s/^\* \(.*\)/\1/p");git co integration;git br -D $branch;'

alias tmp_http_server='originpath=$(pwd);cd /data/sample_files/;(python -m RangeHTTPServer 8080 &> /dev/null &);cd $originpath;'

# docker
alias start_docker='sudo systemctl start docker'
alias run_slsdocker='sudo docker run --rm --name sls -it -v $(pwd):/usr/src/project -v ~/.aws:/root/.aws node:12.16.1 bash'
alias slsdocker='sudo docker attach sls'

alias remove_EOF_newline='truncate -s -1'

alias plugin='cd /e/work/VAST2/plugins'
alias qml='cd /e/work/VAST2/VAST2'
alias uat='cd /e/work/VAST2/UAT'
alias viewcell='cd /e/work/VAST2/ViewCellQml'

export HISTCONTROL=erasedups

# HSTR configuration - add this to ~/.bashrc
alias hh=hstr                    # hh to be alias for hstr
export HSTR_CONFIG=hicolor       # get more colors
shopt -s histappend              # append new history items to .bash_history
export HISTCONTROL=ignorespace   # leading space hides commands from history
export HISTFILESIZE=10000        # increase history file size (default is 500)
export HISTSIZE=${HISTFILESIZE}  # increase history size (default is 500)
# ensure synchronization between bash memory and history file
export PROMPT_COMMAND="history -a; history -n; ${PROMPT_COMMAND}"
# if this is interactive shell, then bind hstr to Ctrl-r (for Vi mode check doc)
if [[ $- =~ .*i.* ]]; then bind '"\C-r": "\C-a hstr -- \C-j"'; fi
# if this is interactive shell, then bind 'kill last command' to Ctrl-x k
if [[ $- =~ .*i.* ]]; then bind '"\C-xk": "\C-a hstr -k \C-j"'; fi
