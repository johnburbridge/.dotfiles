# bindkey -v

HISTFILE=~/.zsh_history
HISTSIZE=5000
SAVEHIST=$HISTSIZE
HISTDUPE=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space 
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
# zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
# zstyle :compinstall filename '/home/jburbridge/.zshrc'

# autoload -Uz compinit
# compinit
autoload bashcompinit && bashcompinit
autoload -Uz compinit && compinit
complete -C '/usr/local/bin/aws_completer' aws


alias ls='ls --color'
alias l='ls -l'
alias la='l -a'
alias lah='la -h'

# autoload -Uz _zinit
# (( ${+_comps} )) && _comps[zinit]=_zinit

# export STARSHIP_CONFIG=~/.config/starship-gruvbox.toml
eval "$(starship init zsh)"
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source $(brew --prefix)/share/zsh-fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
