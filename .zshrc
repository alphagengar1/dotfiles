# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.


# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time Oh My Zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes

if [ "$TERM_PROGRAM" != "Apple_Terminal" ]; then
  eval "$(oh-my-posh init zsh --config $HOME/.config/ohmyposh/amro.toml)"
fi

alias zen="$(oh-my-posh init zsh --config $HOME/.config/ohmyposh/zen.toml)"
alias tokyo="$(oh-my-posh init zsh --config $HOME/.config/ohmyposh/tokyonight_storm.toml)"
alias bubbles="$(oh-my-posh init zsh --config $HOME/.config/ohmyposh/bubbles.toml)"
alias emodipt="$(oh-my-posh init zsh --config $HOME/.config/ohmyposh/emodipt_extend.toml)"
alias amro="$(oh-my-posh init zsh --config $HOME/.config/ohmyposh/amro.toml)"

function prompt() {
  themes=("zen" "tokyo" "bubbles" "emodipt" "amro")
  theme=$(printf "%s\n" "${themes[@]}" | fzf --prompt="Choose a prompt theme: " --height=~50% --layout=reverse --border --exit-0)
  if [[ -z $theme ]]; then
    echo "Nothing selected"
    return 0
  fi
  case $theme in
      zen)
          zen
          ;;
      tokyo)
          tokyo
          ;;
      bubbles)
          bubbles
          ;;
      emodipt)
          emodipt
          ;;
      amro)
          amro
          ;;
      *)
          echo "Invalid theme"
          ;;
  esac
}

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git zsh-autosuggestions zsh-syntax-highlighting copyfile macos dirhistory web-search zsh-vi-mode)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
 if [[ -n $SSH_CONNECTION ]]; then
   export EDITOR='nvim'
 else
   export EDITOR='nvim'
 fi
 #
# history setup
HISTFILE=$HOME/.zhistory
SAVEHIST=1000
HISTSIZE=999
setopt share_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_verify

bindkey "^[[A" history-search-backward
bindkey "^[[B" history-search-forward

alias ls="eza --icons=always"
eval "$(zoxide init zsh)"

unalias fzfopen 2>/dev/null
unalias fzfpre 2>/dev/null

alias fzfpre="fzf --preview 'bat --style=plain --color=always --line-range :500 {}'"
alias fzfopen="nvim \$(fzf --preview 'bat --style=plain --color=always --line-range :500 --paging=always {}')"

alias organize_cp='(cd ~/downloads/code/CP/inProgres && ~/downloads/code/CP/bashScript/organize_cp.sh)'
alias rename_files='(cd ~/downloads/code/CP/inProgres && ~/downloads/code/CP/bashScript/rename_files.sh)'
alias usaco_rename='(cd ~/downloads/code/CP/inProgres && ~/downloads/code/CP/bashScript/usaco_rename.sh)'


# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by Oh My Zsh libs,
# plugins, and themes. Aliases can be placed here, though Oh My Zsh
# users are encouraged to define aliases within a top-level file in
# the $ZSH_CUSTOM folder, with .zsh extension. Examples:
# - $ZSH_CUSTOM/aliases.zsh
# - $ZSH_CUSTOM/macos.zsh
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

alias CP="cd ~/downloads/code/CP"
alias CY="cd ~/downloads/code/cybersec"
alias spt="spotify"
alias rap="spt play uri spotify:playlist:4ynhsxjhZAHoSVjE9CHs5R"
alias doom="spt play uri spotify:playlist:1B8SREqJkh5UX98uakN1yf"
alias psych="spt play uri spotify:playlist:698tVc5dH5gSxsXu4oVGiV"
alias matrix="cmatrix -u 4 -s -a"
eval $(thefuck --alias) 
eval $(thefuck --alias fk)

source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Created by `pipx` on 2024-07-06 17:26:10
export PATH="$PATH:/Users/swrj/.local/bin"

alias nvim-python="NVIM_APPNAME=PythonNvim nvim"

function nvims() {
  items=("Normal" "PythonNvim")
  config=$(printf "%s\n" "${items[@]}" | fzf --prompt=" Neovim Config  " --height=~50% --layout=reverse --border --exit-0)
  if [[ -z $config ]]; then
    echo "Nothing selected"
    return 0
  elif [[ $config == "Normal" ]]; then
    config=""
  fi
  NVIM_APPNAME=$config nvim $@
}

bindkey -s ^a "nvims\n"
