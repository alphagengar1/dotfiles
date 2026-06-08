pyvenv() {
  python3 -m venv .venv && source .venv/bin/activate
}

nvims() {
  local config
  config=$(printf "%s\n" default Zen | fzf --prompt="Neovim Config " --height=~50% --layout=reverse --border --exit-0)

  case "$config" in
    default) NVIM_APPNAME=nvim nvim "$@" ;;
    Zen) NVIM_APPNAME=nvim_zen nvim "$@" ;;
    *) return 0 ;;
  esac
}
