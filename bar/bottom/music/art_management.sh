#! /usr/bin/env zsh

CURRENT_POS=$(playerctl -p spotify position)

if [ ! -f /tmp/cover_art.png ] || [ ${CURRENT_POS%.*} -lt 6 ]; then
    curl $(playerctl -p spotify metadata mpris:artUrl) -o /tmp/cover_art.png

    echo "Updating the cover art"
fi

echo "/tmp/cover_art.png"
