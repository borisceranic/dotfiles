#!/bin/sh

realpath() {
	[[ $1 = /* ]] && echo "$1" || echo "$PWD/${1#./}"
}

BKUP=".backup.$( date +%s )"
DOTFILES=$(dirname $(realpath "$0"))

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
ln -s $DOTFILES/zsh/zshrc $HOME/.zshrc

echo Installing tmux files
mv -f $HOME/.tmux.conf $HOME/$BKUP.tmux.conf
mv -f $HOME/.tmux-osx.conf $HOME/$BKUP.tmux-osx.conf
mv -f $HOME/.tmux-linux.conf $HOME/$BKUP.tmux-linux.conf
ln -s $DOTFILES/tmux/tmux.conf $HOME/.tmux.conf
ln -s $DOTFILES/tmux/tmux-osx.conf $HOME/.tmux-osx.conf
ln -s $DOTFILES/tmux/tmux-linux.conf $HOME/.tmux-linux.conf
