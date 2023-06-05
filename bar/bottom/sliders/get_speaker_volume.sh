#! /usr/bin/env zsh

wpctl get-volume @DEFAULT_AUDIO_SINK@ | grep  -oP "[0-9]\.[0-9]{2}" | read volume;echo ${$(($volume * 100))%.*}
