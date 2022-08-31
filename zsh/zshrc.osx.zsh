# path customization
path=("/usr/local/sbin" "$HOME/sbin" "$HOME/go/bin" "$HOME/.composer/vendor/bin" "$HOME/.local/bin" $path)
export PATH

export GPG_TTY="$(tty)"
export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"
gpgconf --launch gpg-agent

export GITHUB_PAT=""
export GH_AUTH="-u borisceranic:$GITHUB_PAT"

# homebrew cask default options
export HOMEBREW_GITHUB_API_TOKEN=""
export HOMEBREW_NO_ANALYTICS=1

# ls colors
export CLICOLOR=1
export LSCOLORS="ExGxFxDxCxDxDxhbhdacEc"

alias brew-upgrade='brew update; TO_UPGRADE=`brew upgrade --formula --dry-run --quiet`; brew upgrade --formulae; brew cleanup; brew doctor; brew missing; echo $TO_UPGRADE; brew upgrade --casks --dry-run'
alias ports="netstat -p tcp -a -n | grep LISTEN "
alias routes="netstat -r -n"
alias flush-dns="sudo killall -HUP mDNSResponder"

alias git=hub
