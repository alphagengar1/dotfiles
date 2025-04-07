# Profiling (uncomment to debug startup time)
# zmodload zsh/zprof
# Fix for nested functions limit
FUNCNEST=1000

# Skip all compilation checks but manually initialize compinit
skip_global_compinit=1
autoload -Uz compinit && compinit

# Essential path setup
export PATH=$HOME/bin:/usr/local/bin:$PATH
export ZSH="$HOME/.oh-my-zsh"

# History configuration
HISTFILE=$HOME/.zhistory
HISTSIZE=999
SAVEHIST=1000
setopt share_history hist_expire_dups_first hist_ignore_dups hist_verify

# Load theme immediately but efficiently
if [ "$TERM_PROGRAM" != "Apple_Terminal" ]; then
  cache_file="${HOME}/.cache/oh-my-posh-init.zsh"
  if [[ ! -f "$cache_file" ]] || [[ ! -s "$cache_file" ]] || [[ $(find "$cache_file" -mtime +1) ]]; then
    mkdir -p "${HOME}/.cache"
    oh-my-posh init zsh --config $HOME/.config/ohmyposh/emodipt.toml > "$cache_file"
  fi
  source "$cache_file"
fi

# Theme selection function
function prompt() {
  themes=("zen" "tokyo" "bubbles" "emodipt" "amro")
  theme=$(printf "%s\n" "${themes[@]}" | fzf --prompt="Choose a prompt theme: " --height=~50% --layout=reverse --border --exit-0)
  [[ -z $theme ]] && { echo "Nothing selected"; return 0; }
  eval "$(oh-my-posh init zsh --config $HOME/.config/ohmyposh/${theme}.toml)"
}

# Minimal plugin setup
plugins=(git)

# Disable Oh My Zsh auto-updates completely
DISABLE_AUTO_UPDATE="true"
DISABLE_UPDATE_PROMPT="true"
DISABLE_MAGIC_FUNCTIONS="true"
COMPLETION_WAITING_DOTS="true"

# Load Oh My Zsh with minimal features
source $ZSH/oh-my-zsh.sh

# Load autocomplete and syntax highlighting immediately
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Load zoxide
eval "$(zoxide init zsh)"

# Key bindings
bindkey "^[[A" history-search-backward
bindkey "^[[B" history-search-forward

# Environment variables
export EDITOR='nvim'
export PATH="$PATH:/Users/swrj/.local/bin"

# Aliases - grouped by functionality
# File management
alias ls="eza --icons=always"
alias fzfpre="fzf --preview 'bat --style=plain --color=always --line-range :500 {}'"
alias fzfopen="nvim \$(fzf --preview 'bat --style=plain --color=always --line-range :500 --paging=always {}')"

# Development
alias connect_pwn="ssh -i ~/Downloads/Code/CyberSec/pwn/key hacker@pwn.college"
alias organize_cp='(cd ~/downloads/code/CP/inProgress && ~/downloads/code/CP/bashScript/organize_cp.sh)'
alias rename_files='(cd ~/downloads/code/CP/inProgress && ~/downloads/code/CP/bashScript/rename_files.sh)'
alias usaco_rename='(cd ~/downloads/code/CP/inProgress && ~/downloads/code/CP/bashScript/usaco_rename.sh)'

# Lazy load heavy commands
alias fuck='eval $(thefuck $(fc -ln -1)); history -R'
alias python="python3"

alias nvim-zen="NVIM_APPNAME=nvim_zen nvim"

function nvims() {
  items=("default" "Zen")
  config=$(printf "%s\n" "${items[@]}" | fzf --prompt=" Neovim Config " --height=~50% --layout=reverse --border --exit-0)
  if [[ -z $config ]]; then
    echo "Nothing selected"
    return 0
  elif [[ $config == "default" ]]; then
    NVIM_APPNAME=nvim
  elif [[ $config == "Zen" ]]; then
    NVIM_APPNAME=nvim_zen
  fi
  NVIM_APPNAME=$NVIM_APPNAME nvim "$@"
}

# Remove duplicates in $PATH
typeset -U path PATH

# Activate Python venv only if exists and not already activated
if [[ -f ~/.venv/bin/activate ]] && [[ -z "${VIRTUAL_ENV}" ]]; then
  source ~/.venv/bin/activate
fi

. "$HOME/.cargo/env"            # For sh/bash/zsh/ash/dash/pdksh

# Profiling end (uncomment to debug startup time)
# zprof

export PATH=$PATH:/Users/swrj/.spicetify
