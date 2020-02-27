#!/usr/bin/env bash

set -e

EXEC_COMMAND=$1
INSTANCE=$2

# Note what i3 calls "instance" is the first value of the WM_CLASS X property.
# You can find this value with xprop.
I3_MATCHER="[instance=\"$INSTANCE\"]"

TIMEOUT_SECS=5
SLEEP_SECS=0.001

if [[ $(i3-msg "$I3_MATCHER scratchpad show") =~ '"success":false' ]]
then
  i3-msg "exec $EXEC_COMMAND"
  START_TIME=$(date +%s)
  while [[ ! $(i3-msg -t get_tree) =~ "$INSTANCE" ]]
  do
    NOW=$(date +%s)
    DELTA=$(($NOW - $START_TIME))
    if [[ $DELTA -gt $TIMEOUT_SECS ]]
    then
      i3-nagbar -m "Failed to find window for $EXEC_COMMAND"
      exit 1
    fi
    sleep $SLEEP_SECS
  done
  i3-msg "$I3_MATCHER move scratchpad"
  i3-msg "$I3_MATCHER scratchpad show"
  i3-msg "$I3_MATCHER sticky enable"
fi
