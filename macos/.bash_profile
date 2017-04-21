export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

export YELLOW="\[\033[0;33m\]"
export CLEAR="\[\033[0m\]"

source $HOME/homebrew/etc/bash_completion.d/git-prompt.sh
export GIT_PS1_SHOWCOLORHINTS=1
export GIT_PS1_SHOWDIRTYSTATE=1
export GIT_PS1_SHOWUNTRACKEDFILES=1
export GIT_PS1_SHOWDIRTYSTATE=1
export GIT_PS1_SHOWSTASHSTATE=1
export GIT_PS1_SHOWUPSTREAM=auto

export PROMPT_COMMAND='__git_ps1 "\n$YELLOW\w$CLEAR" "\n🌀  "'

export CLICOLOR=1

defaults write -g InitialKeyRepeat -int 10 # normal minimum is 15 (225 ms)
defaults write -g KeyRepeat -int 1 # normal minimum is 2 (30 ms)

export GOPATH=$HOME/git/go
export PATH=$HOME/homebrew/bin:$PATH:/usr/local/opt/go/libexec/bin:$GOPATH/bin

nvm-update() {
  local="$(nvm version node)"
  remote="$(nvm version-remote node)"
  if [[ $local != $remote ]]; then
    echo "upgrading $local -> $remote"
    nvm install node --reinstall-packages-from=node install latest nodejs
    nvm uninstall $local
   else
    echo "already at $remote"
  fi;
}

update-all() {
  echo "> brew"
  brew update
  brew upgrade
  echo "> nvm"
  nvm-update
  echo "> npm"
  npm outdated -g | sed 1d | cut -d ' ' -f1 | xargs npm install -g
  echo "> vim"
  vim +PluginUpdate +qall
}

source ~/git/dotfiles/.bashrc
