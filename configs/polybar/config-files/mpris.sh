#!/bin/bash

player_status=$(playerctl status 2> /dev/null)
current_player=$(playerctl -l | awk 'NR==1{print $1}')

if [ "$player_status" = "Playing" ]; then
  if [ "$current_player" = "spotify" ]; then
	echo "🎧  $(playerctl metadata artist) - $(playerctl metadata title)"
  else
	echo "🎧  $(playerctl metadata artist) - $(playerctl metadata title)      $(playerctl metadata --format '{{ duration(position) }}')/$(playerctl metadata --format '{{ duration(mpris:length) }}') "
  fi
elif [ "$player_status" = "Paused" ]; then
    echo "$(playerctl metadata artist) - $(playerctl metadata title)"
else
    echo ""
fi
