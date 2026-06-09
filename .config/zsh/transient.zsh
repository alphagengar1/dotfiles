# Oh My Posh implements transient prompts by redrawing the previous prompt on
# Enter. That compression is neat, but the redraw can flicker in some terminals.
#
# Set ZSH_TRANSIENT_PROMPT=1 before sourcing .zshrc to keep compression enabled.
: ${ZSH_TRANSIENT_PROMPT:=0}

if [[ "$ZSH_TRANSIENT_PROMPT" != 1 && ${widgets[zle-line-init]-} == user:_omp_zle-line-init ]]; then
  zle -D zle-line-init
fi
