#!/usr/bin/env bash

realpath() {
	[[ $1 = /* ]] && echo "$1" || echo "$PWD/${1#./}"
}

MYDIR=$(dirname $(realpath "$0"))

. $MYDIR/defaults-funcs.sh

success "This script will install core programs required to bootstrap"
success "and configure development and productivity environment on"
success "this Mac OS X computer."
echo
warn "Before continuing, make sure that:"
error "* XCODE IS INSTALLED!"
error "* XCODE HAS BEEN RUN AT LEAST ONCE!"
echo
warn "Last chance to abort cleanly, by pressing CTRL+C."

read

########################## INSTALL BREW & CASK ###########################

info "Installing brew..."
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

info "Installing brew cask..."
brew install caskroom/cask/brew-cask

################### INSTALL PACKAGES VIA BREW & CASK #####################

info "Installing: git, zsh, mosh, tmux, vim"
brew install git git-flow git-flow-clone
brew install zsh zsh-completions zsh-history-substring-search
brew install mosh
brew install tmux reattach-to-user-namespace
brew install vim

info "Installing: gawk"
brew install gawk

########################## CLONING & INSTALLING DOTFILES #################

info "Installing dotfiles"
df=~/dotfiles
if [[ ! -d $df ]]; then
	git clone --recursive https://github.com/borisceranic/dotfiles.git $df
	cd $df
	git remote set-url origin git@github.com:borisceranic/dotfiles.git
else
	cd $df
	git pull
	git submodule update --init --recursive
fi

$df/install.sh
# vim post-install installation and cleaning of plugins
vim -c "PluginInstall" -c "q" -c "q"

success "Finished installing core programs & bootstraping this system."

