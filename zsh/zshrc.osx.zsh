# path customization
path=("$HOME/sbin" "/usr/local/mysql/bin" $path)
export PATH

## brew zsh-completions
fpath=(/usr/local/share/zsh-completions $fpath)

## brew zsh-history-substring-search
source /usr/local/opt/zsh-history-substring-search/zsh-history-substring-search.zsh

# ls colors
export CLICOLOR=1
export LSCOLORS="ExGxFxDxCxDxDxhbhdacEc"

# nvm
export NVM_DIR=~/.nvm
source $(brew --prefix nvm)/nvm.sh
