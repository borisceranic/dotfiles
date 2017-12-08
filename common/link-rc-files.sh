#!/bin/sh

realpath() {
	[[ $1 = /* ]] && echo "$1" || echo "$PWD/${1#./}"
}

if [ -z $DOTFILES ]; then
	DOTFILES=$(dirname $(realpath "$0"))/..
fi

BKUP=".backup.$( date +%s )"

cd $HOME

echo Installing vim files
mv -f $HOME/.vim $HOME/$BKUP.vim
mv -f $HOME/.vimrc $HOME/$BKUP.vimrc
mv -f $HOME/.gvimrc $HOME/$BKUP.gvimrc
ln -s $DOTFILES/vim/vim $HOME/.vim
ln -s $DOTFILES/vim/vimrc $HOME/.vimrc
ln -s $DOTFILES/vim/gvimrc $HOME/.gvimrc

echo Installing zsh files
mv -f $HOME/.zshrc $HOME/$BKUP.zshrc
mv -f $HOME/.zshrc.osx.zsh $HOME/$BKUP.zshrc.osx.zsh
mv -f $HOME/.zshrc.linux.zsh $HOME/$BKUP.zshrc.linux.zsh
ln -s $DOTFILES/zsh/zshrc $HOME/.zshrc
ln -s $DOTFILES/zsh/zshrc.osx.zsh $HOME/.zshrc.osx.zsh
ln -s $DOTFILES/zsh/zshrc.linux.zsh $HOME/.zshrc.linux.zsh

echo Installing git files
mv -f $HOME/.git_template $HOME/$BKUP.git_template
mv -f $HOME/.gitconfig $HOME/$BKUP.gitconfig
mv -f $HOME/.gitignore_global $HOME/$BKUP.gitignore_global
ln -s $DOTFILES/git/git_template $HOME/.git_template
ln -s $DOTFILES/git/gitconfig $HOME/.gitconfig
ln -s $DOTFILES/git/gitignore_global $HOME/.gitignore_global
