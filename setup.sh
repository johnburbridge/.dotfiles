#!/usr/bin/env bash

# install homebrew pre-requisites
sudo apt-get install build-essential procps curl file git

# install brew 
if [ ! -z $(which brew) ];
  then
  homebrew_prefix=$(brew --prefix)
  else
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# echo $homebrew_prefix

# install apps
brew install font-jetbrains-mono-nerd-font
brew install glow
brew install helix
brew install --cask iterm2
brew install --cask intellij-idea
brew install moor
brew install npm
brew install openjdk@21
brew install pipx
brew install starship
brew install stow
brew install yarn
brew install zellij
brew install zsh-autosuggestions
brew install zsh-fast-syntax-highlighting
brew install zsh-autocomplete

# synlink all the dotfiles
stow .
