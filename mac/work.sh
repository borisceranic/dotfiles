#!/usr/bin/env bash

realpath() {
	[[ $1 = /* ]] && echo "$1" || echo "$PWD/${1#./}"
}

MYDIR=$(dirname $(realpath "$0"))

. $MYDIR/defaults-funcs.sh

success "This script will install work related programs."
echo
warn "Press any key to continue. To abort, pressing CTRL+C."

brew cask install 1password
brew cask install dropbox
brew cask install firefox
brew cask install google-chrome
brew cask install hipchat
brew cask install java
brew cask install mysqlworkbench
brew cask install slack
brew cask install sourcetree
brew cask install transmit
brew cask install vagrant
brew cask install vagrant-manager
brew cask install virtualbox
brew cask install vmware-fusion
brew cask install gpgtools
brew cask install iterm2
brew cask install karabiner
brew cask install nvalt
brew cask install tuntap
brew install awscli
brew install boot2docker
brew install elixir
brew install erlang
brew install flow
brew install gnupg2
brew install gpg-agent
brew install highlight
brew install imagemagick
brew install jenv
brew install keybase
brew install mobile-shell
brew install node
brew install nvm
brew install openvpn
brew install php56
brew install php56-intl
brew install rebar
