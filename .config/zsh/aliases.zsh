if command -v eza >/dev/null 2>&1; then
  alias ls="eza --icons=always"
else
  alias ls="ls -G"
fi

alias fzfpre="fzf --preview 'bat --style=plain --color=always --line-range :500 {}'"
alias fzfopen="nvim \$(fzf --preview 'bat --style=plain --color=always --line-range :500 --paging=always {}')"
alias connect_pwn="ssh -i ~/Downloads/Code/CyberSec/pwn/key hacker@pwn.college"
alias python="python3"
alias nvim-zen="NVIM_APPNAME=nvim_zen nvim"
