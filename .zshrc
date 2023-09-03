# A fade of green chevrons
PROMPT='%B%F{35}❯%F{41}❯%F{47}❯%b%f '

# Show the CWD (last part only, and ~ for home dir), and time on the right
RPROMPT='%1~ %*'

# Load the more advanced zsh completions system
autoload -Uz compinit && compinit

# Make globbing case-insensitive, since APFS is (usually) case-insensitive
setopt NO_CASE_GLOB

# Max number of history lines in memory (default 1000)
SAVEHIST=5000

# Max number of history lines in ~/.zsh_history (default 2000)
HISTSIZE=10000

# Don't store duplicate entries in history file
setopt HIST_IGNORE_DUPS

# Updates PATH and some other variables to load brew packages
eval "$(/opt/homebrew/bin/brew shellenv)"

# Defer slow nvm startup until the first time running a node-related command
# https://www.ioannispoulakas.com/2020/02/22/how-to-speed-up-shell-load-while-using-nvm/
lazy_load_nvm() {
  unalias node npm nvm
  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
}
alias node="lazy_load_nvm && node"
alias npm="lazy_load_nvm && npm"
alias nvm="lazy_load_nvm && nvm"