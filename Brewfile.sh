#!/bin/bash
brew update

brew tap peco/peco

brew install zsh
brew install peco
# findに type d つけると遅くなるので代替
brew install ffind

brew install caskroom/cask/brew-cask

brew cask install slack
brew cask install speedlimit
brew cask install alfred

brew cleanup
