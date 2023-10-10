#!/bin/bash

spaces (){
	WORKSPACE_WINDOWS=$(hyprctl workspaces -j | jq 'map({key: .id | tostring, value: {lastwindow: .lastwindowtitle, monitor: .monitor, windows: .windows}}) | from_entries')


    # replace every occurence of '\"' with ''' in WORKSPACE_WINDOWS
    WORKSPACE_WINDOWS=$(echo $WORKSPACE_WINDOWS | sed -E "s/\\\\\"/\\'/g")

    seq 1 10 | jq --argjson values "${WORKSPACE_WINDOWS}" --slurp -Mc 'map(tostring) | map({id: ., windows: ($values[.].windows//0), lastwindow: $values[.].lastwindow, monitor: $values[.].monitor})' \
        | sed -E 's/lastwindow\":\"[^{"]*Mozilla Firefox\",/lastwindow":"󰈹",/g' \
        | sed -E 's/lastwindow\":\"[^{"]*Visual Studio Code[^}"]*\",/lastwindow":"󰨞",/g' \
        | sed -E 's/lastwindow\":\"[^{"]*(Neovim|vim)[^}"]*\",/lastwindow":"",/g' \
        | sed -E 's/lastwindow\":\"[^{"]*Discord[^}]*\",/lastwindow":"󰙯",/g' \
        | sed -E 's/lastwindow\":\"[^{"]*WhatsApp[^}"]*\",/lastwindow":"",/g' \
        | sed -E 's/lastwindow\":\"[^{"]*Spotify[^}"]*\",/lastwindow":"",/g' \
        | sed -E 's/lastwindow\":\"[^{"]*foot[^"}]*\",/lastwindow":"",/g' \
        | sed -E 's/lastwindow\":\"{0,1}[^{}"]{2,}\"{0,1},/lastwindow":false,/g' \
        | sed -E 's/lastwindow\":\"\",/lastwindow":false,/g' 


}

spaces
socat -u UNIX-CONNECT:/tmp/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock - | while read -r line; do
	spaces
done
