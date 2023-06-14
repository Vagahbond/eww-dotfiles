#! /usr/bin/env zsh

echo $(( $(playerctl position -p spotify) * 100 / $(( $(playerctl metadata -p spotify mpris:length) / 1000000 )) )) # | grep -Po \"[0-9]{1,3}\.[0-9]{3}\"
