#!/usr/bin/env bash

# Do not change, unless you wish to update all other hard-coded paths!
DOTFILES="$HOME/dotfiles"
NEW_SHELL="/bin/zsh"

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

if [ ! -x /usr/local/bin/brew ]; then
	info "Installing brew..."
	ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

	info "Installing brew services..."
	brew tap homebrew/services

	info "Installing brew cask..."
	brew tap caskroom/cask
	brew install brew-cask
else
	warn "Homebrew already installed, skipping installation!"
fi

################### INSTALL PACKAGES VIA BREW & CASK #####################

info "Installing: git, vim, atom"
brew install git
brew install vim
brew cask install atom

info "Installing: gawk"
brew install gawk

########################## CLONING & INSTALLING DOTFILES #################

info "Installing dotfiles"
if [[ ! -d $DOTFILES ]]; then
	git clone --recursive https://github.com/borisceranic/dotfiles.git $DOTFILES
	cd $DOTFILES
	git remote set-url origin git@github.com:borisceranic/dotfiles.git
else
	cd $DOTFILES
	git pull
	git submodule update --init --recursive
fi

$DOTFILES/common/link-rc-files.sh

info "Installing Vim plugins"
vim +PluginInstall +qall

info "Installing Atom editor's package pre-requisite modules"
$DOTFILES/atom/reinstall_packages.sh

if [ ! -f /etc/paths.bak ]; then

	PATHSFILE=$DOTFILES/mac/etc-paths
	LAUNCHDDIR=$DOTFILES/mac/launchd
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
else
	warn "Paths and launchctl environments are already configured, skipping..."
fi

if [ "$SHELL" == "$NEW_SHELL" ]; then
	warn "Shell already set to $NEW_SHELL, skipping..."
else
	info "Changing default shell to $NEW_SHELL..."
	sudo chsh -s $NEW_SHELL $USER
	export SHELL="$NEW_SHELL"
fi

success "Finished installing core programs & bootstraping this system."

