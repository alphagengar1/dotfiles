#!/bin/bash
SPOTIFY_EVENT="com.spotify.client.PlaybackStateChanged"
PREVIOUS_COVER=""
COVER_PATH="/tmp/cover.jpg"

play() {
  # Get current state before toggling
  CURRENT_STATE=$(nowplaying-cli getPlaybackState)
  #
  # Predict and set the next state immediately
  if [ "$CURRENT_STATE" = "playing" ]; then
    sketchybar -m --set spotify.indicator label="􀊄"  # Paused icon
  else
    sketchybar -m --set spotify.indicator label="􀊆"  # Playing icon
  fi
  
  # Toggle play/pause state
  nowplaying-cli togglePlayPause &  # Run in background to prevent blocking
  
}

update() {
  args=()


  PLAYING=1
  if [ "$(echo "$INFO" | jq -r '.["Player State"]')" = "Playing" ]; then
    args+=(
    --set spotify.indicator "label=􀊆"    
  )
    PLAYING=0
    TRACK="$(echo "$INFO" | jq -r .Name)"
    ARTIST="$(echo "$INFO" | jq -r .Artist)"
    TRACK=${TRACK:-"Unknown Track"}
    ARTIST=${ARTIST:-"Unknown Artist"}
    if [ ${#TRACK} -gt 20 ]; then
      TRACK="${TRACK:0:17}..."
    fi
  fi
  
  if [ $PLAYING -eq 0 ]; then
    args+=(
      --set spotify.title "label=${TRACK}" 
      --set spotify.artist "label=${ARTIST}" 
      --set spotify.artist "label.font=JetBrainsMono Nerd Font:Italic:10.0"
    )
    
    # Only fetch cover art if we don't have it or if track changed
    CURRENT_TRACK=$(sketchybar --query spotify.title | jq -r .label)
    if [ "$TRACK" != "$CURRENT_TRACK" ]; then
      COVER=$(osascript -e 'tell application "Spotify" to get artwork url of current track')
      if [ "$COVER" != "$PREVIOUS_COVER" ] && [ -n "$COVER" ]; then
        PREVIOUS_COVER="$COVER"
        # Download cover in background to avoid blocking
        (curl -s --max-time 10 "$COVER" -o "$COVER_PATH.tmp" && \
         mv "$COVER_PATH.tmp" "$COVER_PATH" && \
         sketchybar -m --set spotify.anchor background.image="$COVER_PATH" drawing=on) &
      fi
    fi
  else
    args+=(
      --set spotify.indicator "label=􀊄"
    )
  fi
  
  sketchybar -m "${args[@]}"
}

mouse_clicked() {
  case "$NAME" in
    "spotify.play"|"spotify.anchor") 
      play
      ;;
    *) exit
      ;;
  esac
}

popup() {
  sketchybar --set spotify.anchor popup.drawing=$1
}

case "$SENDER" in
  "mouse.clicked") mouse_clicked ;;
  "mouse.entered") popup on ;;
  "mouse.exited"|"mouse.exited.global") popup off ;;
  *) update ;;
esac
