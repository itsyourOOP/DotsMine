#!/bin/sh

yaourt -Syuu
pacaur -u
sudo pacman -Rns $(pacman -Qtdq)

