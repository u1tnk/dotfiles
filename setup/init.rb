#! /usr/bin/env ruby
# -*- coding: utf-8 -*-
require "fileutils"

home = ENV['HOME']
FileUtils.cd home

Dir.mkdir "local" unless FileTest.exist? "local"

File.symlink "dotfiles/.gemrc", ".gemrc" unless FileTest.exist? ".gemrc"
File.symlink "dotfiles/.gitconfig", ".gitconfig" unless FileTest.exist? ".gitconfig"
File.symlink "dotfiles/.tmux.conf", ".tmux.conf" unless FileTest.exist? ".tmux.conf"
File.symlink "dotfiles/.gvimrc", ".gvimrc" unless FileTest.exist? ".gvimrc"
File.symlink "dotfiles/.vrapperrc", ".vrapperrc" unless FileTest.exist? ".vrapperrc"

FileUtils.copy "dotfiles/setup/template/.zshrc", ".zshrc" unless FileTest.exist? ".zshrc"
FileUtils.copy "dotfiles/setup/template/.zshenv", ".zshenv" unless FileTest.exist? ".zshenv"
FileUtils.copy "dotfiles/setup/template/.vimrc", ".vimrc" unless FileTest.exist? ".vimrc"

`sh dotfiles/setup/git_submodule.sh`

#BundleInstallした後vimproc.shを実行
`sh dotfiles/setup/vimproc.sh` if FileTest.exist? ".vim/bundle"

#vimdoc_ja
`svn checkout http://vimdoc-ja.googlecode.com/svn/trunk/runtime dotfiles/.vim/bundle/vimdoc_ja` unless FileTest.exist? ".vim/bundle/vimdoc_ja"

#rsense
unless  FileTest.exist? "local/rsense"
  `git clone http://cx4a.org/repo/rsense.git/ local/rsense`
  `ruby local/rsense/etc/config.rb > ~/.rsense`
end

