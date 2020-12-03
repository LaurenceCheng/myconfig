# User specific environment
PATH="$HOME/.local/bin:$HOME/bin:$PATH"
export PATH

          GREEN="\[\033[01;32m\]"
         YELLOW="\[\033[01;33m\]"
           BLUE="\[\033[01;34m\]"
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

PS1="${PYTHON_VIRTUALENV}${debian_chroot:+($debian_chroot)}${GREEN}\u@\h${COLOR_NONE}:${YELLOW}\w${CYAN} $(parse_git_branch)${COLOR_NONE}\n$ "
}


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
