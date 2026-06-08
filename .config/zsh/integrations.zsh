[[ -r /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]] &&
  source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh

command -v zoxide >/dev/null 2>&1 && eval "$(zoxide init zsh)"

[[ -r "$HOME/.cargo/env" ]] && source "$HOME/.cargo/env"
