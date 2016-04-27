# disable flow control so that C-s doesn't freeze the terminal
# http://unix.stackexchange.com/q/12107
stty -ixon

# sync history across terminals
# http://unix.stackexchange.com/q/1288
shopt -s histappend
export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"
export HISTSIZE=1000000
export HISTFILESIZE=1000000

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
