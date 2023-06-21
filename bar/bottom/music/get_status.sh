#! /usr/bin/env bash 


prevCover=''

# Preventing a bug where when you close and open spotify artist and title disapear
prevArtist=''
prevTitle=''


get_cover() {
  curCover=$1

  if [ "$curCover" != "$prevCover" ] && [ "$curCover" != "" ]; then
    curl $curCover -s -o /tmp/cover_art.png;
    prevCover=$curCover
  fi
}


playerctl -p spotify -F metadata -f '{{title}}\{{artist}}\{{shuffle}}\{{status}}\{{mpris:artUrl}}' 2>/dev/null | while IFS="$(printf '\')" read -r title artist shuffle status cover; do

get_cover $cover;

if [ "$prevArtist" != "$artist" ] && [ "$artist" != "" ]; then
    prevArtist="$artist"
fi

if [ "$prevTitle" != "$title" ] && [ "$title" != "" ]; then
    prevTitle="$title"
fi

echo '{"artist": "'"$prevArtist"'", "title": "'"$prevTitle"'", "status": "'"$status"'", "cover": "/tmp/cover_art.png", "shuffle": "'"$shuffle"'"}'

  prevCover=$cover
done
