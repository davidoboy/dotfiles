#!/bin/bash
unicode="\u001b[90m│"
output_string="$(pacman -Qq | wc -l) (pacman)"
max_length=18

if [ ${#output_string} -gt $max_length ]; then
    truncated_string=$(echo "$output_string" | cut -c 1-$max_length)
    echo -e "$truncated_string $unicode"
else
    spaces_needed=$((max_length - ${#output_string} + 1))
    padding=$(printf "%-${spaces_needed}s" "")
    padded_output="${output_string}${padding}${unicode}"
    echo -e "$padded_output"
fi