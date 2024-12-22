# .dotfiles

My terminal tools and configuration:
* starship
* zellij
* helix
* and other goodies...

Coincidentally they're all written in Rust.

## Setup

1. Install Homebrew:
  ```
  $ /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  ```

2. Clone this repository:
  ```
  $ git clone git@github.com:johnburbridge/.dotfiles.git
  ```

3. Run `setup.sh` to install required tools:
  ```
  $ cd .dotfiles/ && ./setup.sh
  ```

Helix
```
$ sudo add-apt-repository ppa:maveonair/helix-editor
$ sudo apt update
$ sudo apt install helix
```
