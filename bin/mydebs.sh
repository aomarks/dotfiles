#!/usr/bin/env bash

set -e

SYSLOG="/var/log/installer/syslog"
PACKAGES_CACHE="$HOME/data/auto-installed-debs"

if [[ ! -f "$PACKAGES_CACHE" ]]; then
  echo "Sudo is needed to read auto-installed packages from $SYSLOG"
  echo "The package list will be saved to $PACKAGES_CACHE for next time"
  echo
  PACKAGES=$(sudo grep -oP "Unpacking \K[^: ]+" "$SYSLOG" | sort -u)
  mkdir -p "$(dirname "$PACKAGES_CACHE")"
  echo "$PACKAGES" > "$PACKAGES_CACHE"
fi

comm -13 "$PACKAGES_CACHE" <(apt-mark showmanual | sort)
