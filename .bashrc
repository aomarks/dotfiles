# disable flow control so that C-s doesn't freeze the terminal
stty -ixon

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
