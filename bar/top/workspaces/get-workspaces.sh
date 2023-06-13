#!/bin/bash

spaces (){
	WORKSPACE_WINDOWS=$(hyprctl workspaces -j | jq 'map({key: .id | tostring, value: {lastwindow: .lastwindowtitle, monitor: .monitor, windows: .windows}}) | from_entries')
	# seq 1 10 | jq --argjson windows "${WORKSPACE_WINDOWS}" --slurp -Mc 'map(tostring) | map({id: ., windows: ($windows[.]//0)})'
    # WORKSPACE_WINDOWS=$(hyprctl workspaces -j | jq -Mc '[.[] | {id: .id | tostring, lastwindow: .lastwindowtitle, monitor: .monitor, windows: .windows}]')
    seq 1 10 | jq --argjson values "${WORKSPACE_WINDOWS}" --slurp -Mc 'map(tostring) | map({id: ., windows: ($values[.].windows//0), lastwindow: $values[.].lastwindow, monitor: $values[.].monitor})' \
        | sed -E 's/lastwindow\":\"[^{]*Visual Studio Code[^}]*\",/lastwindow":"󰨞",/g' \
        | sed -E 's/lastwindow\":\"[^{]*(Neovim|vim)[^}]*\",/lastwindow":"",/g' \
        | sed -E 's/lastwindow\":\"[^{]*WebCord -[^}]*\",/lastwindow":"󰙯",/g' \
        | sed -E 's/lastwindow\":\"[^{]*WhatsApp[^}]*\",/lastwindow":"",/g' \
        | sed -E 's/lastwindow\":\"[^{]*Spotify[^}]*\",/lastwindow":"",/g' \
        | sed -E 's/lastwindow\":\"[^{]*(bash|zsh|vagahbond@framework)[^}]*\",/lastwindow":"",/g' \
        | sed -E 's/lastwindow\":\"[^{]*Mozilla Firefox\",/lastwindow":"󰈹",/g' \
        | sed -E 's/lastwindow\":\"{0,1}[^{}"]{2,}\"{0,1},/lastwindow":false,/g' \
        | sed -E 's/lastwindow\":\"\",/lastwindow":false,/g' 


}

spaces
socat -u UNIX-CONNECT:/tmp/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock - | while read -r line; do
	spaces
done
