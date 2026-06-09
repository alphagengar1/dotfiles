# Oh My Posh implements transient prompts by redrawing the previous prompt on
# Enter. Keep compression enabled by default, but allow a local opt-out if a
# terminal makes the redraw too distracting.
#
# Set ZSH_TRANSIENT_PROMPT=0 in ~/.zshrc.local to disable compression entirely.
: ${ZSH_TRANSIENT_PROMPT:=1}

if [[ "$ZSH_TRANSIENT_PROMPT" != 1 && ${widgets[zle-line-init]-} == user:_omp_zle-line-init ]]; then
  zle -D zle-line-init
fi
