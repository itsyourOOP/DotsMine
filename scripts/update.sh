#!/bin/sh

yay --combinedupgrade -Syyuu
sudo pacman -Rns $(pacman -Qtdq)

