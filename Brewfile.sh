#!/bin/bash
brew update

brew tap peco/peco

brew install zsh
brew install peco

brew install caskroom/cask/brew-cask

brew cask install slack
brew cask install speedlimit
brew cask install alfred

brew cleanup
