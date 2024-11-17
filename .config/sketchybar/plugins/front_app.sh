#!/bin/bash

if [ "$SENDER" = "front_app_switched" ]; then
  sketchybar --set $NAME label="$INFO" 
  sketchybar --set $NAME icon.background.image="app.$INFO"
  sketchybar --set $NAME icon.background.image.scale=.8
  sketchybar --set $NAME icon.background.image.padding_left=5
  sketchybar --set $NAME icon.background.image.padding_right=7

  sketchybar --set $NAME icon=$ICON icon.padding_right=$ICON_PADDING_RIGHT
  sketchybar --set $NAME.name label="$INFO"
fi

