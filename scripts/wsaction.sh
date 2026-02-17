#!/bin/sh

if [ "$1" = "-g" ]; then
    group=1
    shift
fi

if [ "$#" -ne 2 ]; then
    echo 'Wrong number of arguments. Usage: ./wsaction.fish [-g] <dispatcher> <workspace>'
    exit 1
fi

active_ws=$(hyprctl activeworkspace -j | jq -r '.id')

if [ -n "$group" ]; then
    # Move to group
    target=$(( ( $2 - 1 ) * 10 + active_ws % 10 ))
    hyprctl dispatch "$1" "$target"
else
    # Move to ws in group
    target=$(( ((active_ws - 1) / 10) * 10 + $2 ))
    hyprctl dispatch "$1" "$target"
fi
