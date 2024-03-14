#!/bin/bash
if ! command -v playerctl &> /dev/null; then
    echo "playerctl is not installed."
    exit 1
fi

current_song=$(playerctl -p spotify metadata title)

if [[ -z $current_song ]]; then
    echo "No song is currently playing."
else
    max_length=32

    if (( ${#current_song} > max_length )); then
        current_song=${current_song:0:max_length}
    fi

    total_length=34
    song_length=${#current_song}
    half_spaces=$(( (total_length - song_length) / 2 ))

    if (( song_length % 2 != 0 )); then
        padding_left=$(( half_spaces + 1 ))
    else
        padding_left=$half_spaces
    fi

    padding_left=$(printf "%${padding_left}s" "")
    padding_right=$(printf "%${half_spaces}s" "")

    echo -e "\u001b[90m│${padding_left}\u001b[37m$current_song${padding_right}\u001b[90m│"
fi