#!/bin/bash

if mpc status | awk 'NR==2' | grep playing
then
	mpc next
else
	playerctl-cmus next
fi
