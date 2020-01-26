#!/usr/bin/env bash

set -e

URL=$1
INSTANCE=$2

if [[ $(i3-msg "[instance=\"$INSTANCE\"]" scratchpad show) =~ '"success":false' ]]; then
  google-chrome --app=$URL
  i3-msg "[instance=\"$INSTANCE\"] move scratchpad"
  i3-msg "[instance=\"$INSTANCE\"] scratchpad show"
  i3-msg "[instance=\"$INSTANCE\"] sticky enable"
fi