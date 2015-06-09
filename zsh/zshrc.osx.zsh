# path customization
path=("$HOME/sbin" "/usr/local/mysql/bin" $path)
export PATH

# ls colors
export CLICOLOR=1
export LSCOLORS="ExGxFxDxCxDxDxhbhdacEc"

# nvm
export NVM_DIR=~/.nvm
source $(brew --prefix nvm)/nvm.sh

# invoke jenv to configure java development environment
eval "$(jenv init -)"
