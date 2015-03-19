#!/usr/bin/env bash

realpath() {
	[[ $1 = /* ]] && echo "$1" || echo "$PWD/${1#./}"
}

MYDIR=$(dirname $(realpath "$0"))

. $MYDIR/defaults-funcs.sh

success "This script will install work related programs."
echo
warn "Press any key to continue. To abort, pressing CTRL+C."

##################### INSTALL PACKAGES VIA BREW & CASK ###################

success "Password and identity management tools"
info "Installing (cask): dropbox"
brew cask install dropbox
info "Installing (cask): google-drive"
brew cask install google-drive
info "Installing (cask): 1password"
brew cask install 1password
info "Installing: gnupg2 (alias for gpg2)"
brew install gnupg2
info "Installing (cask): gpgtools"
brew cask install gpgtools
info "Installing: keybase"
brew install keybase

success "Libraries"
info "Installing (cask): java"
brew cask install java

success "Productivity tools, viewers"
info "Installing (cask): iterm2"
brew cask install iterm2
info "Installing (cask): karabiner"
brew cask install karabiner
info "Installing (cask): nvalt"
brew cask install nvalt

success "Browsers, chat, remote access, downloaders"
info "Installing (cask): firefox"
brew cask install firefox
info "Installing (cask): transmit"
brew cask install transmit
info "Installing (cask): cord"
brew cask install cord
info "Installing (cask): hipchat"
brew cask install hipchat

success "VMs, environments, languages, libraries"
info "Installing (cask): vagrant"
brew cask install vagrant
info "Installing (cask): vagrant-manager"
brew cask install vagrant-manager
info "Installing (cask): virtualbox"
brew cask install virtualbox
info "Installing (cask): vmware-fusion"
brew cask install vmware-fusion
info "Installing (vagrant) Plugin: vagrant-vmware-fusion"
vagrant plugin install vagrant-vmware-fusion
warn "You need to register vagrant-vmware-fusion plugin using command:"
warn "    vagrant plugin license vagrant-vmware-fusion license.lic"
echo
info "Installing: erlang"
brew install erlang
info "Installing: elixir"
brew install elixir
