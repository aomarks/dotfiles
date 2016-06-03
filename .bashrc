# disable flow control so that C-s doesn't freeze the terminal
# http://unix.stackexchange.com/q/12107
stty -ixon

# when a shell exits and writes history to disk, append rather than truncate
shopt -s histappend

# append new history lines to disk before each prompt (i.e. on return)
export PROMPT_COMMAND="history -a; $PROMPT_COMMAND"

# max lines of history in memory per shell
export HISTSIZE=1000000

# max lines of history on disk
export HISTFILESIZE=1000000

# don't store commands prefixed with a space in history
# de-duplicate identical adjacent history lines (most recent wins)
export HISTCONTROL=ignorespace:erasedups

# sync history with disk (append new lines; clear; reload from disk)
alias gh="history -a; history -c; history -r"

# cd to the first matching parent directory
up() {
  cd $(pwd | sed "s/\.*\($1[^\/]*\).*/\1/")
  pwd
}

# cd to the first matching child directory
down() {
  cd $(find . -type d -name $1 -print -quit)
  pwd
}

# grep stdin to match patterns in any order
grepy() {
  cmd="cat"
  for pattern in "$@"; do
    cmd="$cmd | grep -i --color=always \"$pattern\""
  done
  eval $cmd
}

# search unique history
hi() {
  history | \
  grep -vE "^[[:blank:]]*[[:digit:]]+[[:blank:]]+(history |$FUNCNAME )" | \
  sort -k2 -k1nr | uniq -f1 | sort -n | grepy "$@"
}

# search notes
no() {
  cd $HOME/git/notes
  awk '{print FILENAME"\t"$0}' * | grepy "$@"
  cd - > /dev/null
}
