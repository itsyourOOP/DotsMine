#!/usr/bin/env bash
oomoxify-cli -g ~/.cache/wal/colors-oomox

if pgrep spotify; then
    pkill spotify
    spotify-adkiller-dns-block &
fi

