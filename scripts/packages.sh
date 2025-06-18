#!/bin/bash

# Sync package databases
sudo pacman -Sy >/dev/null 2>&1

# Count official repository updates
official_updates=$(pacman -Qu | wc -l)
# echo $official_updates

# Count AUR updates
aur_updates=$(yay -Qua | wc -l)
# echo $aur_updates

# Sum total updates
total_updates=$((official_updates + aur_updates))
# echo $total_updates

# Output the total number of updates
echo "$total_updates"
