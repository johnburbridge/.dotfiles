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

eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

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
