# path customization
path=("/usr/local/sbin" "$HOME/sbin" "$HOME/go/bin" "$HOME/.composer/vendor/bin" "$HOME/.local/bin" $path)
export PATH

# homebrew cask default options
export HOMEBREW_GITHUB_API_TOKEN=""
export HOMEBREW_NO_ANALYTICS=1

# ls colors
export CLICOLOR=1
export LSCOLORS="ExGxFxDxCxDxDxhbhdacEc"

alias brew-upgrade="brew upgrade; brew cleanup; brew cask cleanup; brew doctor; brew missing; brew cask outdated"
alias ports="netstat -p tcp -a -n | grep LISTEN "
alias routes="netstat -r -n"
alias flush-dns="sudo killall -HUP mDNSResponder"
