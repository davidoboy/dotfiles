#!/bin/sh

start() {
  if ! pgrep -f "$1" ;
  then
    "$@"&
  fi
}

start flameshot
start picom --config=$HOME/.config/awesome/theme/picom.conf
start volctl
start blueman-applet
start nm-applet
start redshift-gtk -l 51.604389:-0.146790

# --config=$HOME/.config/awesome/theme/picom.conf