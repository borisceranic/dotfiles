# path customization
path=("$HOME/sbin" "$HOME/.composer/vendor/bin" $path)
export PATH

source '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc'
source '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc'

# homebrew cask default options
export HOMEBREW_GITHUB_API_TOKEN=""
export HOMEBREW_NO_ANALYTICS=1

# ls colors
export CLICOLOR=1
export LSCOLORS="ExGxFxDxCxDxDxhbhdacEc"

alias brew-upgrade="brew upgrade --all; brew cleanup; brew cask cleanup; brew doctor; brew missing"
alias ports="netstat -p tcp -a -n | grep LISTEN "
alias routes="netstat -r -n"
alias flush-dns="sudo killall -HUP mDNSResponder"
