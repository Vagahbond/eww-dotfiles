#!/bin/bash

handle (){


  ACTIVE_WORKSPACE=$(hyprctl monitors | grep -m1 "active workspace:" | grep -o "(.\+)" | grep -o "[^()]")

  NB_WINDOWS=$(hyprctl workspaces | grep -a1 "workspace ID .\+ (${ACTIVE_WORKSPACE})" | grep "windows: " | grep -o "[0-9]\+")

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


