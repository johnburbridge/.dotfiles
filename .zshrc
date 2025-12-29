HISTFILE=~/.zsh_history
HISTSIZE=5000
SAVEHIST=$HISTSIZE
HISTDUPE=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space 
# setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

alias ls='ls --color'
alias l='ls -l'
alias la='l -a'
alias lah='la -h'
alias k=kubectl
alias t=task

#eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# export STARSHIP_CONFIG=~/.config/starship-gruvbox.toml
eval "$(starship init zsh)"


source $(brew --prefix)/share/zsh-fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
source $(brew --prefix)/share/zsh-autocomplete/zsh-autocomplete.plugin.zsh
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh

ZSH_AUTOSUGGEST_STRATEGY=(history completion)

bindkey -e
bindkey "^<ESC>[D" backward-word

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
# zstyle :compinstall filename '/home/jburbridge/.zshrc'
zstyle ':autocomplete:menu-search:*' insert-unambiguous yes

# Capture timestamp when command completes
precmd() {
  export LAST_COMMAND_TIMESTAMP=$(date '+%H:%M:%S')
}

# Claude Code OpenTelemetry Configuration
export CLAUDE_CODE_ENABLE_TELEMETRY=1
export OTEL_METRICS_EXPORTER=otlp
export OTEL_LOGS_EXPORTER=otlp
export OTEL_EXPORTER_OTLP_PROTOCOL=grpc
export OTEL_EXPORTER_OTLP_ENDPOINT=http://localhost:4317
export OTEL_METRIC_EXPORT_INTERVAL=10000  # 10s for faster feedback
export PATH="/opt/homebrew/opt/ruby@3.3/bin:$PATH"
