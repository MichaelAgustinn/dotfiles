#!/bin/bash
awww img "$1" --transition-type grow
python3 ~/.config/hypr/scripts/wallpaper_colors.py "$1"
