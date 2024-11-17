#!/bin/bash
# Max number of characters so it fits nicely to the right of the notch
# MAY NOT WORK WITH NON-ENGLISH CHARACTERS
MAX_LENGTH=34
HALF_LENGTH=$(((MAX_LENGTH + 1) / 2))
SPOTIFY_JSON="$INFO"
COVER_PATH="/tmp/cover.jpg"
PREVIOUS_COVER=""
# Function to sanitize the track name by removing "FEAT", parentheses, and extra spaces
sanitize_track_name() {
    local track=$1
    # First, remove everything from "FEAT" or "feat" or "FEAT." and onward
    track=$(echo "$track" | sed -E 's/\s*(Feat|feat|FEAT).*//')
    # Now remove any remaining parentheses and their content
    track=$(echo "$track" | tr -d '()[]')
    # Remove any extra spaces at the end
    track=$(echo "$track" | sed 's/[[:space:]]*$//')
    echo "$track"
}
# Function to update album cover art
update_cover_art() {
    COVER=$(osascript -e 'tell application "Spotify" to get artwork url of current track')
    if [ "$COVER" != "$PREVIOUS_COVER" ] && [ -n "$COVER" ]; then
        PREVIOUS_COVER="$COVER"
        (
            curl -s --max-time 200 "$COVER" -o "$COVER_PATH.tmp" && \
            if [ -f "$COVER_PATH.tmp" ]; then
                mv "$COVER_PATH.tmp" "$COVER_PATH"
                sketchybar --set cover background.image="$COVER_PATH" \
                                    background.image.scale=0.040 \
                                    background.image.corner_radius=7 \
                                    background.image.padding_left=18
            fi
        ) &
    fi
}
# Function to update track information
update_track() {
    if [[ -z $SPOTIFY_JSON ]]; then
        sketchybar --set $NAME icon.color=0xffeed49f label.drawing=no
        return
    fi
    PLAYER_STATE=$(echo "$SPOTIFY_JSON" | jq -r '.["Player State"]')
    if [ $PLAYER_STATE = "Playing" ]; then
        TRACK="$(echo "$SPOTIFY_JSON" | jq -r .Name)"
        TRACK=$(sanitize_track_name "$TRACK") # Remove "FEAT" part, parentheses, and spaces
        ARTIST="$(echo "$SPOTIFY_JSON" | jq -r .Artist)"
        # Calculations so it fits nicely
        TRACK_LENGTH=${#TRACK}
        ARTIST_LENGTH=${#ARTIST}
        if [ $((TRACK_LENGTH + ARTIST_LENGTH)) -gt $MAX_LENGTH ]; then
            # If the total length exceeds the max
            if [ $TRACK_LENGTH -gt $HALF_LENGTH ] && [ $ARTIST_LENGTH -gt $HALF_LENGTH ]; then
                # If both the track and artist are too long, cut both at half length - 1
                TRACK="${TRACK:0:$((MAX_LENGTH % 2 == 0 ? HALF_LENGTH - 2 : HALF_LENGTH - 1))}…"
                ARTIST="${ARTIST:0:$((HALF_LENGTH - 2))}…"
            elif [ $TRACK_LENGTH -gt $HALF_LENGTH ]; then
                # Else if only the track is too long, cut it by the difference of the max length and artist length
                TRACK="${TRACK:0:$((MAX_LENGTH - ARTIST_LENGTH - 1))}…"
            elif [ $ARTIST_LENGTH -gt $HALF_LENGTH ]; then
                ARTIST="${ARTIST:0:$((MAX_LENGTH - TRACK_LENGTH - 1))}…"
            fi
        fi
        
        sketchybar --set $NAME label="${TRACK}   ${ARTIST}" label.drawing=yes icon.color=0xffa6da95
        update_cover_art # Fetch and update the cover art
    elif [ $PLAYER_STATE = "Paused" ]; then
        sketchybar --set $NAME icon.color=0xffeed49f
    elif [ $PLAYER_STATE = "Stopped" ]; then
        sketchybar --set $NAME icon.color=0xffeed49f label.drawing=no
    else
        sketchybar --set $NAME icon.color=0xffeed49f
    fi
}
case "$SENDER" in
"mouse.clicked")
    osascript -e 'tell application "Spotify" to playpause'
    ;;
*)
    update_track
    ;;
esac
