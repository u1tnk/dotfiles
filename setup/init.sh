#!/bin/sh

cd ~
ln -s dotfiles/.gemrc
ln -s dotfiles/.gitconfig
ln -s dotfiles/.tmux.conf

cp dotfiles/setup/template/.zshrc .zshrc
cp dotfiles/setup/template/.vimrc .vimrc

dotfiles/setup/git_submodule.sh
#BundleInstallした後vimproc.shを実行

