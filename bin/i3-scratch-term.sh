#!/usr/bin/env bash

set -e

if [[ $(i3-msg "[instance=\"scratchterm\"] scratchpad show") =~ '"success":false' ]]
then
  i3-msg "exec i3-sensible-terminal -name scratchterm"
  while [[ $(xwininfo -all -root) != *scratchterm* ]]
  do
   sleep 0.001
  done
  i3-msg "[instance=\"scratchterm\"] move scratchpad"
  i3-msg "[instance=\"scratchterm\"] scratchpad show"
  i3-msg "[instance=\"scratchterm\"] sticky enable"
fi