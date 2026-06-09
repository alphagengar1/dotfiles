_omp_config="$HOME/.config/ohmyposh/emodipt.toml"

if [[ "$TERM_PROGRAM" != "Apple_Terminal" ]] && command -v oh-my-posh >/dev/null 2>&1 && [[ -r "$_omp_config" ]]; then
  _omp_cache="${XDG_CACHE_HOME:-$HOME/.cache}/oh-my-posh/init.zsh"

  if [[ ! -s "$_omp_cache" || "$_omp_config" -nt "$_omp_cache" ]]; then
    mkdir -p "${_omp_cache:h}"
    oh-my-posh init zsh --config "$_omp_config" >| "$_omp_cache"
  fi

  source "$_omp_cache"
fi

unset _omp_config _omp_cache

prompt() {
  local theme_dir="$HOME/.config/ohmyposh"
  local -a themes
  local theme

  themes=("$theme_dir"/*.toml(N:t:r))
  (( ${#themes[@]} == 0 )) && return 1

  theme=$(printf "%s\n" "${themes[@]}" | sort | fzf --prompt="Choose a prompt theme: " --height=~50% --layout=reverse --border --exit-0)

  [[ -z "$theme" ]] && return 0
  eval "$(oh-my-posh init zsh --config "$theme_dir/$theme.toml")"
}
