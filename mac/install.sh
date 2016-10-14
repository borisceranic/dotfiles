#!/usr/bin/env bash

# Do not change, unless you wish to update all other hard-coded paths!
DOTFILES="$HOME/dotfiles"

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

# Temporarily setting "brew cask" Application install location
export HOMEBREW_CASK_OPTS="--appdir=/Applications"

info "Installing brew cask..."
brew install caskroom/cask/brew-cask

################### INSTALL PACKAGES VIA BREW & CASK #####################

info "Installing: git, zsh, mosh, tmux, vim"
brew install git
brew install zsh
brew install mosh
brew install tmux reattach-to-user-namespace
brew install vim
brew install atom

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

$df/common/link-rc-files.sh

info "Installing Vim plugins"
vim +PluginInstall +qall

info "Installing Atom editor's package pre-requisite modules"
$MYDIR/atom/reinstall_packages.sh

PATHSFILE=$df/mac/etc-paths
LAUNCHDDIR=$df/mac/launchd
info "Copying paths file into /etc/paths. File contents is between dashed lines:"
warn "-------------------------------------"
warn $(cat $PATHSFILE)
warn "-------------------------------------"
info "Make sure this is okay. If it is not, abort the script using CTRL+C!"
warn "Your password is required to install paths file!"
sudo cp /etc/paths /etc/paths.bak
sudo cp $PATHSFILE /etc/paths

info "Configuring automatic global path updating (user- and root-level)"
sudo cp $LAUNCHDDIR/environment /etc/environment
sudo cp $LAUNCHDDIR/environment.plist /Library/LaunchDaemons/environment.plist
sudo cp $LAUNCHDDIR/environment.user.plist /Library/LaunchAgents/environment.user.plist

launchctl load -w /Library/LaunchAgents/environment.user.plist
sudo launchctl load -w /Library/LaunchDaemons/environment.plist

success "Finished installing core programs & bootstraping this system."

