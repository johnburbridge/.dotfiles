#!/bin/bash

# Read JSON input from stdin
input=$(cat)

# Extract values from JSON
current_dir=$(echo "$input" | jq -r '.workspace.current_dir')
model=$(echo "$input" | jq -r '.model.display_name')

# ============================================================================
# LINE 1: Starship-style prompt
# ============================================================================

# Get hostname
hostname=$(hostname -s)

# Get OS icon (using Nerd Font icons)
case "$(uname -s)" in
  Darwin)
    os_icon=$'\uf179'  # macOS icon
    ;;
  Linux)
    os_icon=$'\uf17c'
    ;;
  CYGWIN*|MINGW*|MSYS*)
    os_icon=$'\uf17a'
    ;;
  *)
    os_icon=$'\uf109'
    ;;
esac

# Change to the current directory to get git info
cd "$current_dir" 2>/dev/null

# Get directory name with icon
dir_name=$(basename "$current_dir")

# Get git branch
git_branch=""
git_status_info=""
if git rev-parse --git-dir >/dev/null 2>&1; then
  git_branch=$(git branch --show-current 2>/dev/null)

  # Get git status
  if [ -n "$git_branch" ]; then
    # Check for modifications
    if [ -n "$(git status --porcelain 2>/dev/null)" ]; then
      git_status_info="*"
    fi

    # Check ahead/behind
    remote_branch=$(git rev-parse --abbrev-ref @{upstream} 2>/dev/null)
    if [ -n "$remote_branch" ]; then
      ahead=$(git rev-list --count HEAD.."$remote_branch" 2>/dev/null || echo "0")
      behind=$(git rev-list --count "$remote_branch"..HEAD 2>/dev/null || echo "0")

      if [ "$ahead" -gt 0 ]; then
        git_status_info="${git_status_info}⇣${ahead}"
      fi
      if [ "$behind" -gt 0 ]; then
        git_status_info="${git_status_info}⇡${behind}"
      fi
    fi
  fi
fi

# Build Line 1 - Rainbow colors from red to violet
# OS icon (red)
printf '\033[31m%s\033[0m' "$os_icon"

# Separator
printf '\033[2m ▸ \033[0m'

# Hostname (orange - brighter, more distinct)
printf '\033[38;5;214m%s\033[0m' "$hostname"

# Separator
printf '\033[2m ▸ \033[0m'

# Directory name (yellow - pure yellow without green)
printf '\033[93m%s\033[0m' "$dir_name"

# Separator
printf '\033[2m ▸ \033[0m'

# Git branch if available (green - proper green)
if [ -n "$git_branch" ]; then
  printf '\033[38;5;82m%s\033[0m' "$git_branch"

  # Separator
  printf '\033[2m ▸ \033[0m'
fi

# Status dot (deep blue for rainbow progression)
printf '\033[34m●\033[0m'

# Separator
printf '\033[2m ▸ \033[0m'

# Model name (light blue/indigo)
printf '\033[38;5;39m%s\033[0m' "$model"

# Separator
printf '\033[2m ▸ \033[0m'

# ============================================================================
# Context window progress bar (on same line)
# ============================================================================

# Extract context window data (use current_usage for actual context, not cumulative)
CONTEXT_SIZE=$(echo "$input" | jq -r '.context_window.context_window_size')
USAGE=$(echo "$input" | jq '.context_window.current_usage')

# Calculate percentage (matches /context calculation)
if [ "$USAGE" != "null" ] && [ "$CONTEXT_SIZE" -gt 0 ] 2>/dev/null; then
    INPUT=$(echo "$USAGE" | jq -r '.input_tokens // 0')
    OUTPUT=$(echo "$USAGE" | jq -r '.output_tokens // 0')
    CACHE_CREATE=$(echo "$USAGE" | jq -r '.cache_creation_input_tokens // 0')
    CACHE_READ=$(echo "$USAGE" | jq -r '.cache_read_input_tokens // 0')
    TOTAL=$((INPUT + OUTPUT + CACHE_CREATE + CACHE_READ))
    PERCENT=$((TOTAL * 100 / CONTEXT_SIZE))
else
    PERCENT=0
fi

# Build progress bar using Nerd Fonts glyphs
BAR_WIDTH=20
filled=$((PERCENT * BAR_WIDTH / 100))
empty=$((BAR_WIDTH - filled))

# Purple/violet color for the progress bar (completing the rainbow)
printf '\033[38;5;141m'

# Left cap (filled if any progress, else empty)
if [ $filled -gt 0 ]; then
    printf $'\uee03'  # filled left
else
    printf $'\uee00'  # empty left
fi

# Middle segments
for ((i=0; i<filled && i<BAR_WIDTH; i++)); do
    printf $'\uee04'  # filled mid
done
for ((i=0; i<empty; i++)); do
    printf $'\uee01'  # empty mid
done

# Right cap (filled if 100%, else empty)
if [ $PERCENT -ge 100 ]; then
    printf $'\uee05'  # filled right
else
    printf $'\uee02'  # empty right
fi

# Percentage
printf ' %d%%\033[0m' "$PERCENT"
