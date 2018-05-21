#!/bin/bash

# Specifying the icon(s) in the script
# This allows us to change its appearance conditionally
icon=" "

player_status=$(playerctl-cmus status 2> /dev/null)
if [[ $? -eq 0 ]]; then
    metadata="$(playerctl-cmus metadata artist) - $(playerctl-cmus metadata title)"
fi

# Foreground color formatting tags are optional
if [[ $player_status = "Playing" ]]; then
    #echo "%{F#D08770}$icon $metadata"       # Orange when playing
    echo "${xrdb:*.color6}$icon $metadata"
elif [[ $player_status = "Paused" ]]; then
    echo "%{F#65737E}$icon $metadata"       # Greyed out info when paused
else
    echo "%{F#65737E}$icon"                 # Greyed out icon when stopped
fi
