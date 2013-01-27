#! /usr/bin/env ruby
# -*- coding: utf-8 -*-
require "fileutils"

home = ENV['HOME']
FileUtils.cd home

Dir.mkdir "local" unless FileTest.exist? "local"
Dir.mkdir "temp" unless FileTest.exist? "temp"
Dir.mkdir "apps" unless FileTest.exist? "apps"

File.symlink "dotfiles/.gemrc", ".gemrc" unless FileTest.exist? ".gemrc"
File.symlink "dotfiles/.gitconfig", ".gitconfig" unless FileTest.exist? ".gitconfig"
File.symlink "dotfiles/.tmux.conf", ".tmux.conf" unless FileTest.exist? ".tmux.conf"
File.symlink "dotfiles/.gvimrc", ".gvimrc" unless FileTest.exist? ".gvimrc"
File.symlink "dotfiles/.vrapperrc", ".vrapperrc" unless FileTest.exist? ".vrapperrc"
File.symlink "dotfiles/.my.cnf", ".my.cnf" unless FileTest.exist? ".my.cnf"

FileUtils.copy "dotfiles/setup/template/.zshrc", ".zshrc" unless FileTest.exist? ".zshrc"
FileUtils.copy "dotfiles/setup/template/.zshenv", ".zshenv" unless FileTest.exist? ".zshenv"
FileUtils.copy "dotfiles/setup/template/.vimrc", ".vimrc" unless FileTest.exist? ".vimrc"

print `sh dotfiles/setup/git_submodule.sh`

#vimdoc_ja
unless  FileTest.exist? "dotfiles/.vim/bundle/vimdoc_ja"
  print `svn checkout http://vimdoc-ja.googlecode.com/svn/trunk/runtime dotfiles/.vim/bundle/vimdoc_ja` unless FileTest.exist? ".vim/bundle/vimdoc_ja"
end

#rsense
unless  FileTest.exist? "local/rsense"
  print `git clone git://github.com/m2ym/rsense.git local/rsense`
  print `ruby local/rsense/etc/config.rb > ~/.rsense`
end

