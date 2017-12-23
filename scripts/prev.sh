#!/bin/bash

if mpc status | awk 'NR==2' | grep playing
then
	mpc prev
else
	playerctl-cmus previous
fi
