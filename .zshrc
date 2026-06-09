# Profiling helpers:
# zmodload zsh/zprof
# zprof

export ZDOTDIR="$HOME"
export ZSH_CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/zsh"

_source_zsh_config() {
  local file="$ZSH_CONFIG_DIR/$1.zsh"
  [[ -r "$file" ]] && source "$file"
}

_source_zsh_config env
_source_zsh_config path
_source_zsh_config history
_source_zsh_config local
_source_zsh_config completion
_source_zsh_config oh-my-zsh
_source_zsh_config prompt
_source_zsh_config transient
_source_zsh_config integrations
_source_zsh_config nvm
_source_zsh_config keybindings
_source_zsh_config aliases
_source_zsh_config navigation
_source_zsh_config functions
_source_zsh_config syntax-highlighting

unset -f _source_zsh_config
