# Dotfiles (GNU Stow)

This repo mirrors `$HOME`. The repo root is the Stow package. 
Use Stow from this directory to (re)link everything into `~`.

## Quick start
```sh
cd /Users/swrj/dotfiles
stow -t /Users/swrj .
```

## Refresh / fix broken links
```sh
cd /Users/swrj/dotfiles
stow -R -t /Users/swrj .
```

## Remove all links (unstow)
```sh
cd /Users/swrj/dotfiles
stow -D -t /Users/swrj .
```

## Add a new tool config
1. Move the config into this repo (mirroring its path in `~`).
2. Re-stow.

Examples:
```sh
# ~/.config/<tool>
mv /Users/swrj/.config/<tool> /Users/swrj/dotfiles/.config/<tool>

# ~/.<file>
mv /Users/swrj/.<file> /Users/swrj/dotfiles/.<file>

cd /Users/swrj/dotfiles
stow -R -t /Users/swrj .
```

## Remove a tool config
```sh
rm -rf /Users/swrj/dotfiles/.config/<tool>
cd /Users/swrj/dotfiles
stow -R -t /Users/swrj .
```

## Install Stow
```sh
brew install stow
```
