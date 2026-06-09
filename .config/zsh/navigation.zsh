_silent_ls_after_chpwd() {
  {
    if command -v eza >/dev/null 2>&1; then
      eza --icons=always . >/dev/null 2>&1
    else
      command ls . >/dev/null 2>&1
    fi
  } </dev/null &|
}

autoload -Uz add-zsh-hook
add-zsh-hook -d chpwd _silent_ls_after_chpwd 2>/dev/null
add-zsh-hook chpwd _silent_ls_after_chpwd
