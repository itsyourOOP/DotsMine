#!/bin/bash

if mpc status | awk 'NR==2' | grep playing
then
	mpc stop
else
	playerctl-cmus stop
fi
