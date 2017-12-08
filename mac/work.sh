#!/usr/bin/env bash

DOTFILES=$HOME/dotfiles

realpath() {
	[[ $1 = /* ]] && echo "$1" || echo "$PWD/${1#./}"
}

MYDIR=$(dirname $(realpath "$0"))

. $MYDIR/defaults-funcs.sh

success "This script will install work related programs."
echo
warn "Press any key to continue. To abort, pressing CTRL+C."

brew tap homebrew/php

brew cask install 1password
brew cask install dropbox
brew cask install google-chrome
brew cask install gpgtools
brew cask install iterm2
brew cask install java
brew cask install keybase
brew cask install mysqlworkbench
brew cask install nvalt
brew cask install postman
brew cask install robo-3t
brew cask install slack
brew cask install sourcetree
brew cask install transmit
brew cask install visual-studio-code
brew install awscli
brew install docker
brew install docker-compose
brew install docker-machine
brew install docker-machine-driver-xhyve
brew install docker-machine-nfs
brew install flow
brew install gnupg2
brew install gpg-agent
brew install highlight
brew install imagemagick
brew install mobile-shell
brew install node
brew install php71
brew install php71-intl
brew install php71-mongodb
