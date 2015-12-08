#!/bin/sh

realpath() {
	[[ $1 = /* ]] && echo "$1" || echo "$PWD/${1#./}"
}

BKUP=".backup.$( date +%s )"
DOTFILES=$(dirname $(realpath "$0"))
ST3="$HOME/Library/Application Support/Sublime Text 3"

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

echo Installing tmux files
mv -f $HOME/.tmux.conf $HOME/$BKUP.tmux.conf
mv -f $HOME/.tmux-osx.conf $HOME/$BKUP.tmux-osx.conf
mv -f $HOME/.tmux-linux.conf $HOME/$BKUP.tmux-linux.conf
ln -s $DOTFILES/tmux/tmux.conf $HOME/.tmux.conf
ln -s $DOTFILES/tmux/tmux-osx.conf $HOME/.tmux-osx.conf
ln -s $DOTFILES/tmux/tmux-linux.conf $HOME/.tmux-linux.conf

echo Installing git files
mv -f $HOME/.gitconfig $HOME/$BKUP.gitconfig
mv -f $HOME/.gitignore_global $HOME/$BKUP.gitignore_global
ln -s $DOTFILES/git/gitconfig $HOME/.gitconfig
ln -s $DOTFILES/git/gitignore_global $HOME/.gitignore_global

echo Installing Sublime Text 3 files
if [[ -d "$ST3" ]]; then
	mv "$ST3" "$ST3$BKUP.dotfiles"
fi
ln -s "$DOTFILES/st3" "$ST3"
