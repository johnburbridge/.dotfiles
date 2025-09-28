# .dotfiles

My terminal tools and configuration powered by [go-task](https://taskfile.dev/) with support for work and home environments.

## Tools Included

### CLI Environment
* **starship** - Cross-shell prompt
* **zellij** - Terminal multiplexer
* **helix** - Modern text editor
* **neovim** - Extensible text editor
* **JetBrains Mono Nerd Font** - Programming font with ligatures

### Development Tools
* **IntelliJ IDEA** - IDE (macOS only)
* **GitHub CLI** - Git workflow integration
* **Node.js & Yarn** - JavaScript runtime and package manager
* **Python & pipx** - Python tools and isolated package installation
* **Java** - Environment-specific JDK installation
* **jq & yq** - JSON and YAML processors

### System Utilities
* **btop & htop** - System monitors
* **tree** - Directory structure viewer
* **GNU stow** - Dotfiles management
* **glow** - Markdown viewer
* **wget** - File downloader

## Quick Setup

### Basic Installation
```bash
# Clone repository
git clone git@github.com:johnburbridge/.dotfiles.git ~/.dotfiles
cd ~/.dotfiles

# Run setup (defaults to home environment, installs everything)
./setup.sh
```

### Environment-Specific Setup

#### Work Environment
```bash
# Full work setup (uses Apple JDK for licensing compliance)
./setup.sh --work --all

# Just development tools for work
./setup.sh --work --dev
```

#### Home Environment
```bash
# Full home setup (uses OpenJDK)
./setup.sh --home --all

# Just CLI tools at home
./setup.sh --cli
```

### Selective Installation
```bash
./setup.sh --cli      # CLI tools only
./setup.sh --dev      # Development tools only
./setup.sh --system   # System utilities only
./setup.sh --utils    # General utilities only
```

## Environment Support

### Work Environment
- **macOS only** (exclusive work platform)
- **Apple JDK 21** (licensing compliance)
- Corporate proxy support (configurable)
- Work-specific configurations

### Home Environment
- **macOS & Linux** (Ubuntu/Mint)
- **OpenJDK 21** (open source)
- Personal development setup
- Optional gaming/entertainment tools

## Manual Setup (Alternative)

If you prefer using task commands directly:

```bash
# Install prerequisites
brew install go-task

# Set environment (optional, defaults to 'home')
export DOTFILES_ENV=work  # or 'home'

# Run specific tasks
task setup                # Full setup
task install:cli         # CLI tools only
task install:dev         # Development tools only
task check-env           # Check environment
```

## Task Commands

View all available tasks:
```bash
task --list
```

Common tasks:
- `task setup` - Complete environment setup
- `task homebrew:install` - Install Homebrew
- `task configs:link` - Link dotfiles with stow
- `task configs:check` - Check linked configurations
- `task <category>:check` - Check installation status

## File Structure
```
.dotfiles/
├── setup.sh              # User-friendly wrapper script
├── Taskfile.yml           # Main task orchestration
├── tasks/
│   ├── homebrew.yml       # Homebrew installation
│   ├── packages/
│   │   ├── cli.yml        # CLI tools
│   │   ├── development.yml # Dev tools (with Java handling)
│   │   ├── system.yml     # System utilities
│   │   └── utils.yml      # General utilities
│   ├── configs.yml        # Stow configuration linking
│   └── environments/
│       ├── work.yml       # Work-specific tasks
│       └── home.yml       # Home-specific tasks
├── .config/               # Application configurations
├── .zshrc                 # Zsh configuration
├── .zshenv                # Zsh environment
└── .gitconfig             # Git configuration
```

## Features

- **Idempotent**: Safe to run multiple times
- **Environment-aware**: Different configs for work/home
- **Cross-platform**: macOS and Linux support
- **Selective**: Install only what you need
- **Modern**: Uses go-task for better organization
- **Safe**: Backs up existing configurations

## Troubleshooting

### Check Prerequisites
```bash
./setup.sh --help         # Show usage information
task check-env           # Verify environment variables
task homebrew:check-brew  # Check Homebrew installation
```

### Verify Installation
```bash
task cli:check           # Check CLI tools
task dev:check           # Check development tools
task configs:check       # Check configuration links
```

### Environment Issues
```bash
# Work environment validation
task work:validate-work-env

# Home environment validation
task home:validate-home-env
```