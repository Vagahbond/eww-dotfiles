#! /usr/bin/env zsh

OUTPUT=$(wpctl get-volume @DEFAULT_AUDIO_SINK@)
VOLUME=$(echo $OUTPUT | grep  -oP "[0-9]\.[0-9]{2}" | read volume;echo ${$(($volume * 100))%.*})

if  echo $OUTPUT | grep -q "[MUTED]" ; then
    MUTED=true
else
    MUTED=false
fi

echo "{ \"muted\": ${MUTED}, \"value\": ${VOLUME} }"

