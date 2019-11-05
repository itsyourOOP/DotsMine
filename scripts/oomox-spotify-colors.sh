#!/usr/bin/env bash
oomoxify-cli -g -s /opt/spotify/Apps/ ~/.cache/wal/colors-oomox

if pgrep spotify; then
    pkill spotify
    nohup spotify > /dev/null &
fi

