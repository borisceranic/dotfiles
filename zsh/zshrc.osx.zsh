# path customization
path=("$HOME/sbin" $path)
export PATH

# homebrew cask default options
export HOMEBREW_GITHUB_API_TOKEN=""
export HOMEBREW_NO_ANALYTICS=1

nvm_prefix=$(brew --prefix nvm)
if [ ! -z $nvm_prefix ]; then
	export NVM_DIR="$HOME/.nvm"
	source "$(brew --prefix nvm)/nvm.sh"
fi

# ls colors
export CLICOLOR=1
export LSCOLORS="ExGxFxDxCxDxDxhbhdacEc"

alias brew-upgrade="brew upgrade --all; brew cleanup; brew cask cleanup; brew doctor; brew missing"
alias ports="netstat -p tcp -a -n | grep LISTEN "
alias routes="netstat -r -n"
alias flush-dns="sudo killall -HUP mDNSResponder"
