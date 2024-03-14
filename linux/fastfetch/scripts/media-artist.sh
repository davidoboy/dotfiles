#!/bin/bash
if ! command -v playerctl &> /dev/null; then
    echo "playerctl is not installed."
    exit 1
fi

current_artist=$(playerctl -p spotify metadata artist)

if [[ -z $current_artist ]]; then
    echo "No song is currently playing."
else
    max_length=32

    if (( ${#current_artist} > max_length )); then
        current_artist=${current_artist:0:max_length}
    fi

    total_length=34
    artist_length=${#current_artist}
    half_spaces=$(( (total_length - artist_length) / 2 ))

    if (( artist_length % 2 != 0 )); then
        padding_left=$(( half_spaces + 1 ))
    else
        padding_left=$half_spaces
    fi

    padding_left=$(printf "%${padding_left}s" "")
    padding_right=$(printf "%${half_spaces}s" "")

    echo -e "\u001b[90m│${padding_left}\u001b[37m$current_artist${padding_right}\u001b[90m│"
fi