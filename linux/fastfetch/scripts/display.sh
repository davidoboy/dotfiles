#!/bin/bash
unicode="\u001b[90m│"
max_length=23
resolution=$(xrandr | grep -oP 'current \K[^,]*' | sed 's/[^0-9x]*//g')
refresh_rate=$(xrandr | grep -oP "${resolution}.*\*" | grep -oP '\d+\.\d+' | cut -d '.' -f1)
output_string="${resolution} @ ${refresh_rate}Hz"

if [ ${#output_string} -gt $max_length ]; then
    truncated_string=$(echo "$output_string" | cut -c 1-$max_length)
    echo -e "$truncated_string $unicode"
else
    spaces_needed=$((max_length - ${#output_string} + 1))
    padding=$(printf "%-${spaces_needed}s" "")
    padded_output="${output_string}${padding}${unicode}"
    echo -e "$padded_output"
fi