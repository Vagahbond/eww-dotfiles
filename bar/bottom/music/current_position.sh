#! /usr/bin/env bash

#echo $(( $(playerctl position -p spotify) * 100 / $(( $(playerctl metadata -p spotify mpris:length) / 1000000 )) )) 2> /dev/null # | grep -Po \"[0-9]{1,3}\.[0-9]{3}\"

get_position() {
  echo "${1:+$(awk 'BEGIN{printf "%.2f", '"$1"' / '"$2"' * 100}')}" | xargs printf "%.0f\n"
}

playerctl -p spotify -F metadata -f '{{mpris:length}}\{{position}}' 2>/dev/null | while IFS="$(printf '\')" read -r len pos; do
  position="$(get_position "$pos" "${len:-1}")"

  echo "$position"
done
