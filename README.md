# .dotfiles

A repository with zsh and other .dotfile configurations.

## Setup

Install Homebrew:
```
$ /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

Install `stow`:
```
$ brew install stow
```

Clone this repository:
```
$ git clone git@github.com:johnburbridge/.dotfiles.git
```

Install `zinit`:
```
$ bash -c "$(curl --fail --show-error --silent --location https://raw.githubusercontent.com/zdharma-continuum/zinit/HEAD/scripts/install.sh)"
```

## Tools

Zellij:

```
$ wget https://github.com/zellij-org/zellij/releases/download/v0.40.1/zellij-x86_64-unknown-linux-musl.tar.gz
$ tar -xvf zellij-x86_64-unknown-linux-musl.tar.gz
$ mv zellij /usr/local/bin/
```

Helix:
```
$ sudo add-apt-repository ppa:maveonair/helix-editor
$ sudo apt update
$ sudo apt install helix
```
