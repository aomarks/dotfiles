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

# how are timestamps formatted by the history command
export HISTTIMEFORMAT="[%Y-%m-%d %H:%M:%S] "

# sync history with disk
gh() {
  history -a # append new history to disk
  history -c # clear in memory history
  history -r # reload all history from disk
}

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
  # assuming output format is "number  [date time] command"
  history | \
  # sort by command and then ascending history number
  sort -k4 -k1nr | \
  # remove duplicate commands, preferring the most recent
  uniq -f3 | \
  # re-sort by history number
  sort -n | \
  # filter out history commands (including this one) because they are boring
  grep -vE '] (history|hi)( |$|\|)' | \
  # filter for terms
  grepy "$@"
}

# search notes
no() {
  cd $HOME/notes
  awk '{print FILENAME"\t"$0}' */* | grepy "$@"
  cd - > /dev/null
}

recompile-ycm() {
  cd ~/.vim/bundle/YouCompleteMe
  ./install.py --clang-completer --gocode-completer --tern-completer
}
