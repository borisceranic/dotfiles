#!/bin/sh

cd $HOME
BKUP=".backup.$( date +%s )"
DOTFILES="$( cd "$( dirname "$0" )" && pwd )"

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
ln -s $DOTFILES/tmux/tmux.conf $HOME/.tmux.conf
