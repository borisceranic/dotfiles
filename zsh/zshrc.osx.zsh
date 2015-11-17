# path customization
path=("$HOME/sbin" $path)
export PATH

# ls colors
export CLICOLOR=1
export LSCOLORS="ExGxFxDxCxDxDxhbhdacEc"

# nvm
export NVM_DIR=~/.nvm
source $(brew --prefix nvm)/nvm.sh

# invoke jenv to configure java development environment
eval "$(jenv init -)"
