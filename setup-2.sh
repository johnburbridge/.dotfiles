#!/usr/bin/env bash

# TODO: make these idempodent
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

echo >> /Users/john/.zprofile
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> /Users/john/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"
    
brew install vim htop tree helix zellij

brew install --cask google-chrome

brew install --cask iterm2

