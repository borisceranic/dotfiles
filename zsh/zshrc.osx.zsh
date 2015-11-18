# path customization
path=("$HOME/sbin" $path)
export PATH

# homebrew cask default options
export HOMEBREW_CASK_OPTS="--appdir=/Applications"

# ls colors
export CLICOLOR=1
export LSCOLORS="ExGxFxDxCxDxDxhbhdacEc"

# nvm
export NVM_DIR=~/.nvm
source $(brew --prefix nvm)/nvm.sh

# invoke jenv to configure java development environment
eval "$(jenv init -)"
