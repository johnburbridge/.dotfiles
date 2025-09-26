#!/usr/bin/env bash

set -euo pipefail

# Default values
DOTFILES_ENV="home"
INSTALL_TARGET="setup"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

usage() {
    echo "Usage: $0 [environment] [target]"
    echo ""
    echo "Environment options:"
    echo "  --work    Set up for work environment"
    echo "  --home    Set up for home environment (default)"
    echo ""
    echo "Target options:"
    echo "  --all     Complete setup (default)"
    echo "  --cli     Install CLI tools only"
    echo "  --dev     Install development tools only"
    echo "  --system  Install system utilities only"
    echo "  --utils   Install general utilities only"
    echo ""
    echo "Examples:"
    echo "  $0                    # Home setup, everything"
    echo "  $0 --work --all       # Work setup, everything"
    echo "  $0 --cli              # Just CLI tools at home"
    echo "  $0 --work --dev       # Just dev tools at work"
    echo ""
}

log() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

warn() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

error() {
    echo -e "${RED}[ERROR]${NC} $1"
    exit 1
}

success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

check_prerequisites() {
    log "Checking prerequisites..."

    # Check if go-task is installed
    if ! command -v task &> /dev/null; then
        warn "go-task not found. Installing via homebrew..."
        if ! command -v brew &> /dev/null; then
            log "Installing Homebrew first..."
            /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

            # Add Homebrew to PATH for current session
            if [[ "$OSTYPE" == "linux-gnu"* ]]; then
                eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
            elif [[ "$OSTYPE" == "darwin"* ]]; then
                eval "$(/opt/homebrew/bin/brew shellenv)"
            fi
        fi
        brew install go-task
    fi

    success "Prerequisites check completed"
}

parse_args() {
    while [[ $# -gt 0 ]]; do
        case $1 in
            --work)
                DOTFILES_ENV="work"
                shift
                ;;
            --home)
                DOTFILES_ENV="home"
                shift
                ;;
            --all)
                INSTALL_TARGET="setup"
                shift
                ;;
            --cli)
                INSTALL_TARGET="install:cli"
                shift
                ;;
            --dev)
                INSTALL_TARGET="install:dev"
                shift
                ;;
            --system)
                INSTALL_TARGET="install:system"
                shift
                ;;
            --utils)
                INSTALL_TARGET="install:utils"
                shift
                ;;
            -h|--help)
                usage
                exit 0
                ;;
            *)
                error "Unknown option: $1"
                ;;
        esac
    done
}

main() {
    parse_args "$@"

    log "Starting dotfiles setup..."
    log "Environment: $DOTFILES_ENV"
    log "Target: $INSTALL_TARGET"

    check_prerequisites

    # Export environment variable for task
    export DOTFILES_ENV

    # Run the appropriate task
    log "Running: task $INSTALL_TARGET"
    task "$INSTALL_TARGET"

    success "Dotfiles setup completed successfully!"
    log "Environment: $DOTFILES_ENV"
    log "Target: $INSTALL_TARGET"
}

# Run main function with all arguments
main "$@"