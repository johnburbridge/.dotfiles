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
- `task audit` - Audit Homebrew packages (see Homebrew Audit section)
- `task homebrew:install` - Install Homebrew
- `task configs:link` - Link dotfiles with stow
- `task configs:check` - Check linked configurations
- `task <category>:check` - Check installation status

## Homebrew Audit

The audit system helps you track which Homebrew packages are installed on your system but not managed in your dotfiles configuration. This is useful for:
- **Discovering packages** you've installed manually that should be in version control
- **Identifying orphaned packages** you may have forgotten about
- **Maintaining consistency** across machines by ensuring all packages are documented

### Running an Audit

```bash
# Full audit report (formulae, casks, and taps)
task audit
# or
task homebrew:audit

# Focused audits for specific package types
task homebrew:audit-formulae    # Only show unmanaged formulae
task homebrew:audit-casks       # Only show unmanaged casks
task homebrew:audit-taps        # Only show unmanaged taps
```

### Understanding the Output

The audit report shows two categories:

**UNMANAGED PACKAGES** - Installed via Homebrew but not in your dotfiles:
```
Formulae (34):
  - terraform
  - kubectl
  - helm
  ...

Casks (9):
  - docker
  - slack
  ...

Taps (1):
  - hashicorp/tap
```

**MISSING PACKAGES** - In your dotfiles config but not currently installed:
```
Formulae (4):
  - nvim
  - yarn
  ...
```

### Adding Packages to Management

When you find packages you want to manage, add them to the centralized lists in `tasks/homebrew.yml`:

1. **Edit the vars section** in `tasks/homebrew.yml`:
   ```yaml
   vars:
     MANAGED_FORMULAE_BASE: |
       existing-package
       new-package-to-add    # Add your package here
       another-package

     MANAGED_CASKS_BASE: |
       existing-cask
       new-cask-to-add       # Add casks here
   ```

2. **Environment-specific packages** go in the appropriate vars:
   - `MANAGED_FORMULAE_HOME` - Home environment only
   - `MANAGED_FORMULAE_WORK` - Work environment only
   - `MANAGED_CASKS_WORK` - Work casks (e.g., corporate apps)

3. **Add installation logic** in the appropriate task file:
   - `tasks/packages/cli.yml` - Terminal and shell tools
   - `tasks/packages/development.yml` - Programming tools
   - `tasks/packages/system.yml` - System utilities
   - `tasks/packages/utils.yml` - General utilities

4. **Re-run the audit** to verify:
   ```bash
   task audit
   ```

### Workflow Example

```bash
# 1. Run audit to see what's unmanaged
task audit

# 2. Review the output and decide what to keep
#    - Add important packages to tasks/homebrew.yml
#    - Remove unwanted packages: brew uninstall <package>

# 3. Add installation tasks for the packages you're keeping
#    Edit tasks/packages/*.yml files

# 4. Verify everything is now managed
task audit

# 5. Commit your changes
git add tasks/homebrew.yml tasks/packages/*.yml
git commit -m "chore: add terraform and kubectl to managed packages"
```

### Generated Files

The audit creates Brewfiles in `homebrew/` (gitignored):
- `Brewfile.actual` - Current system state from `brew bundle dump`
- `Brewfile.expected` - Generated from your managed package lists

These files are temporary and regenerated each audit run.

## File Structure
```
.dotfiles/
├── setup.sh              # User-friendly wrapper script
├── Taskfile.yml           # Main task orchestration
├── tasks/
│   ├── homebrew.yml       # Homebrew installation & audit
│   ├── packages/
│   │   ├── cli.yml        # CLI tools
│   │   ├── development.yml # Dev tools (with Java handling)
│   │   ├── system.yml     # System utilities
│   │   └── utils.yml      # General utilities
│   ├── configs.yml        # Stow configuration linking
│   └── environments/
│       ├── work.yml       # Work-specific tasks
│       └── home.yml       # Home-specific tasks
├── homebrew/              # Generated Brewfiles (gitignored)
│   ├── Brewfile.actual    # Current system state
│   └── Brewfile.expected  # Managed package list
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