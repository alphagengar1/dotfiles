#!/bin/bash

SPOTIFY_EVENT="com.spotify.client.PlaybackStateChanged"
COVER="/tmp/cover.jpg"
TRACK="$(echo "$INFO" | jq -r .Name)"
ARTIST="$(echo "$INFO" | jq -r .Artist)"

# Define component configurations using tables
spotify_anchor=(
  script="$PLUGIN_DIR/spotify.sh"
  click_script="$play"
  popup.horizontal=on
  popup.align=center
  popup.height=150
  background.image="$COVER"
  background.image.drawing=on
  background.drawing=on
  background.image.scale=0.040
  background.image.corner_radius=7
  shadow=on
  drawing=on
  y_offset=1
)

spotify_indicator=(
  label="􀊆"
  drawing=true
)

spotify_title=(
  label="${TRACK}"
  label.font="SF Pro:Bold:14.0"
  drawing=true
)

spotify_artist=(
  label="${ARTIST}"
  label.font="JetBrainsMono Nerd Font:Italic:10.0"
  drawing=true
)

# Add and configure items
sketchybar --add event spotify_change $SPOTIFY_EVENT \
           --add item spotify.anchor e \
           --set spotify.anchor "${spotify_anchor[@]}" \
           --subscribe spotify.anchor spotify_change \
                                      mouse.clicked \
           \
           --add item spotify.indicator e \
           --set spotify.indicator "${spotify_indicator[@]}" \
           --subscribe spotify.indicator spotify_change \
                                         mouse.clicked \
           \
           --add item spotify.title e \
           --set spotify.title "${spotify_tit[@]}" \
           --subscribe spotify.title spotify_change \
           \
           --add item spotify.artist e \
           --set spotify.artist "${spotify_art[@]}" \
           --subscribe spotify.artist spotify_change
