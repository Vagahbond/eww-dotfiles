#!/bin/bash

handle (){


  ACTIVE_WORKSPACE=$(hyprctl monitors -j | jq '.[] | select(.name=="eDP-1") | .activeWorkspace.id')

  NB_WINDOWS=$(hyprctl clients -j | jq "[.[] | select(.workspace.id==${ACTIVE_WORKSPACE} and .floating==false)] | length")

  if [[ ${NB_WINDOWS} = 1 ]]; then
      mode="fullscreen"
  else
      mode="tiled"
  fi
  
  echo "{ \"mode\": \"${mode}\" }"
}

handle
socat -u UNIX-CONNECT:/tmp/hypr/$(echo $HYPRLAND_INSTANCE_SIGNATURE)/.socket2.sock - | while read -r line; do 
  handle $line; 
done 


