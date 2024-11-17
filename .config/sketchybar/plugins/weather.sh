#!/usr/bin/env zsh

IP=$(curl -s https://ipinfo.io/ip)
LOCATION_JSON=$(curl -s https://ipinfo.io/$IP/json)
LOCATION="$(echo $LOCATION_JSON | jq '.city' | tr -d '"')"
REGION="$(echo $LOCATION_JSON | jq '.region' | tr -d '"')"
COUNTRY="$(echo $LOCATION_JSON | jq '.country' | tr -d '"')"

# Line below replaces spaces with +
LOCATION_ESCAPED="${LOCATION// /+}+${REGION// /+}"
WEATHER_JSON=$(curl -s "wttr.in/$LOCATION_ESCAPED?format=j1")
# Fallback if empty
if [ -z $WEATHER_JSON ]; then
    sketchybar --set $NAME label=$LOCATION
    return
fi

TEMPERATURE=$(echo $WEATHER_JSON | jq '.current_condition[0].temp_C' | tr -d '"')
WEATHER_DESCRIPTION=$(echo $WEATHER_JSON | jq '.current_condition[0].weatherDesc[0].value' | tr -d '"' | sed 's/\(.\{25\}\).*/\1.../')

# Weather icon mapping
get_weather_icon() {
    local description=$(echo "$1" | tr '[:upper:]' '[:lower:]' | xargs)  # Normalize input
    case "$description" in
        *rain*|*drizzle*) ICON="󰖗" ;;       # Rain
        *snow*|*sleet*) ICON="󰖘" ;;       # Snow
        *cloud*|*overcast*) 
            if [[ "$description" == *"partly cloudy"* || "$description" == *"partly sunny"* ]]; then
                ICON="󰖕"                   # Partly cloudy
            else
                ICON="󰖐"                   # Cloud
            fi
            ;;
        *clear*|*sunny*) ICON="󰖙" ;;       # Sun
        *thunder*|*lightning*) ICON="󰖓" ;; # Thunder
        *fog*|*mist*) ICON="󰖑" ;;         # Fog
        *) ICON="󰖐" ;;                   # Default to cloud
    esac
    echo "$ICON"
}

WEATHER_ICON=$(get_weather_icon $WEATHER_DESCRIPTION)
sketchybar --set $NAME label="$LOCATION  $WEATHER_ICON  $TEMPERATURE°F $WEATHER_DESCRIPTION"
