#!/bin/bash

# Function to get the focused application
get_focused_app() {
  focused_app=$(yabai -m query --windows --window | jq -r ".app")
  echo "$focused_app"
}

# Function to change label highlight color based on the app
update_label_color() {
  focused_app=$(get_focused_app)

  case "$focused_app" in
    "Spotify")
      color=0xff1db954 # Spotify Green
      ;;
    "Google Chrome")
      color=0xff4285f4  # Chrome Blue
      ;;
    "Finder")
      color=0xffffcc00  # Finder Yellow
      ;;
    "Discord")
      color=0xff5865f2  # VS Code Blue
      ;;
    "Safari")
      color=0xff1f97ef
      ;;
    *)
      color=$RED # Default Red (adjust to your red)
      ;;
  esac

  # Apply the color to the label highlight
  sketchybar --set $NAME label.highlight_color=$color
}

update() {
  source "$CONFIG_DIR/colors.sh"
  COLOR=$BACKGROUND_2
  if [ "$SELECTED" = "true" ]; then
    COLOR=$GREY
  fi
  update_label_color
  sketchybar --set $NAME icon.highlight=$SELECTED \
                         label.highlight=$SELECTED \
                         background.border_color=$COLOR
}

set_space_label() {
  sketchybar --set $NAME icon="$@"
}

mouse_clicked() {
  if [ "$BUTTON" = "right" ]; then
    yabai -m space --destroy $SID
  else
    if [ "$MODIFIER" = "shift" ]; then
      SPACE_LABEL="$(osascript -e "return (text returned of (display dialog \"Give a name to space $NAME:\" default answer \"\" with icon note buttons {\"Cancel\", \"Continue\"} default button \"Continue\"))")"
      if [ $? -eq 0 ]; then
        if [ "$SPACE_LABEL" = "" ]; then
          set_space_label "${NAME:6}"
        else
          set_space_label "${NAME:6} ($SPACE_LABEL)"
        fi
      fi
    else
      yabai -m space --focus $SID 2>/dev/null
    fi
  fi
}

case "$SENDER" in
  "mouse.clicked") mouse_clicked
  ;;
  *) update
  ;;
esac
