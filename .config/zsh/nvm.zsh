_load_nvm() {
  unset -f nvm node npm npx corepack _load_nvm

  local nvm_prefix="${HOMEBREW_PREFIX:-/opt/homebrew}/opt/nvm"
  if [[ -r "$nvm_prefix/nvm.sh" ]]; then
    source "$nvm_prefix/nvm.sh"
  elif [[ -r "$NVM_DIR/nvm.sh" ]]; then
    source "$NVM_DIR/nvm.sh"
  else
    return 127
  fi
}

nvm() { _load_nvm && nvm "$@"; }
node() { _load_nvm && node "$@"; }
npm() { _load_nvm && npm "$@"; }
npx() { _load_nvm && npx "$@"; }
corepack() { _load_nvm && corepack "$@"; }
