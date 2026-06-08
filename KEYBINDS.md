# Keybinds

This file is the index for keyboard/mouse remaps. Source files live in this repo;
generated app snapshots and automatic backups should stay out of git.

**Legend**
hyper = shift + ctrl + cmd + alt (Caps Lock remapped in Karabiner)

## Sources of truth

- `~/.skhdrc` -> `~/dotfiles/.skhdrc`
- `~/.config/karabiner` -> `~/dotfiles/.config/karabiner`
- `~/.hammerspoon` -> `~/dotfiles/.hammerspoon`
- Arc active keybindings: `~/Library/Application Support/Arc/StorableKeyBindings.json`
- macOS system hotkeys: `~/Library/Preferences/com.apple.symbolichotkeys.plist`

**skhd (yabai)**
- `hyper + j` -> focus window south
- `hyper + k` -> focus window north
- `hyper + h` -> focus window west
- `hyper + l` -> focus window east
- `hyper + r` -> rotate space 270 deg
- `hyper + y` -> mirror space y-axis
- `hyper + x` -> mirror space x-axis
- `hyper + t` -> toggle float (grid 4:4:1:1:2:270)
- `hyper + m` -> toggle zoom fullscreen
- `hyper + e` -> balance space
- `hyper + f` -> toggle float
- `hyper + s` -> yabai -m window --display west; yabai -m display --focus west
- `hyper + g` -> yabai -m window --display east; yabai -m display --focus east
- `hyper + p` -> yabai -m window --space prev
- `hyper + n` -> yabai -m window --space next
- `hyper + 1` -> yabai -m window --space 1
- `hyper + 2` -> yabai -m window --space 2
- `hyper + 3` -> yabai -m window --space 3
- `hyper + 4` -> yabai -m window --space 4
- `hyper + 5` -> yabai -m window --space 5
- `hyper + 6` -> yabai -m window --space 6
- `hyper + 7` -> yabai -m window --space 7
- `hyper + left` -> resize window (right -20 0)
- `hyper + up` -> resize window (bottom 0 20)
- `hyper + down` -> resize window (top 0 -20)
- `hyper + right` -> resize window (left 20 0)
- `hyper + a` -> anchor window
- `hyper + q` -> stop yabai service
- `hyper + 8` -> start yabai service
- `hyper + 0` -> restart yabai service

**Karabiner**
- `caps_lock` -> hyper (shift+ctrl+option+command)
- `mouse button3` -> left_control+up_arrow
- `mouse button4` -> left_control+right_arrow
- `mouse button5` -> left_control+left_arrow
