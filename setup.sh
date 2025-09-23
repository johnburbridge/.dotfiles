#!/usr/bin/env bash

# install homebrew pre-requisites
sudo apt-get install build-essential procps curl file git

# install brew 
if [ -z $(which brew) ];
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# echo $homebrew_prefix

# cli environment
brew install --cask iterm2
brew install \
  font-jetbrains-mono-nerd-font \ # needed for zellij's ligatures
  starship \
  stow \
  zellij \
  zsh-autosuggestions \
  zsh-fast-syntax-highlighting \
  zsh-autocomplete

# utilities
brew install glow \
  go-task \
  helix \
  moor \
  nvim \
  wget

# system
brew install btop \ 
  htop \
  tree

# install development tools
brew install --cask intellij-idea
brew install jq \
  npm \
  openjdk@21 \
  pipx \
  yarn \
  syq

# synlink all the dotfiles
stow .
