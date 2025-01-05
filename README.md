# .dotfiles

My terminal tools and configuration:
* starship
* zellij
* helix
* and other goodies...

Coincidentally they're all written in Rust.

## Setup

1. Install zsh (Ubuntu only)
```
$ sudo apt update -y && sudo apt install zsh
$ chsh /usr/bin/zsh
```

2. Install Homebrew:
```
$ /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

3. Clone this repository:
```
$ git clone git@github.com:johnburbridge/.dotfiles.git
```

4. Run `setup.sh` to install required tools:
```
$ cd .dotfiles/ && ./setup.sh
```

