#!/bin/bash

if mpc status | awk 'NR==2' | grep 'playing\|paused'
then 
	mpc toggle
else
	playerctl-cmus play-pause
fi

