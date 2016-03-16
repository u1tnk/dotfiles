#! /usr/bin/env ruby
# -*- coding: utf-8 -*-
require "fileutils"

home = ENV['HOME']
FileUtils.cd home

%w(local temp apps).each do |x|
  Dir.mkdir x unless FileTest.exist? x
end

[
  {dest: ".zprezto", src: "dotfiles/prezto"},
  {dest: ".gemrc", src: "dotfiles/gemrc"},
  {dest: ".gitconfig", src: "dotfiles/gitconfig"},
  {dest: ".tmux.conf", src: "dotfiles/tmux.conf"},
  {dest: ".gvimrc", src: "dotfiles/gvimrc"},
  {dest: ".my.cnf", src: "dotfiles/my.cnf"},
  {dest: ".amazonrc", src: "Dropbox (Personal)/dotfiles/.amazonrc"},
  {dest: ".zlogin", src: "dotfiles/prezto/runcoms/zlogin"},
  {dest: ".zlogout", src: "dotfiles/prezto/runcoms/zlogout"},
  {dest: ".zprofile", src: "dotfiles/prezto/runcoms/zprofile"},
].each do |x|
  File.symlink x[:src], x[:dest] unless FileTest.symlink? x[:dest]
end

# .zhistoryはファイルが勝手にできるので
if FileTest.file? ".zhistory"
  FileUtils.rm ".zhistory"
  File.symlink "Dropbox (Personal)/dotfiles/.zhistory", ".zhistory"
end

if FileTest.exist? ".zshrc"
  `cat dotfiles/setup/template/zshrc >> .zshrc` if `grep dotfiles .zshrc` == ""
else
  FileUtils.copy "dotfiles/setup/template/zshrc", ".zshrc" unless FileTest.exist? ".zshrc"
end

%w(zshenv vimrc zpreztorc).each do |x|
  FileUtils.copy "dotfiles/setup/template/#{x}", ".#{x}" unless FileTest.file? ".#{x}"
end

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

