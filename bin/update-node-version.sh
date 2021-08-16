#!/usr/bin/env bash

set -e
set -u

INSTALLED=$(node --version || echo "NONE")

TARBASE=$(
  curl --silent --show-error --fail \
  https://nodejs.org/dist/latest/SHASUMS256.txt \
  | grep -oE node-v.+linux-x64 | head -n1)

LATEST=$(echo $TARBASE | grep -Eo "v[0-9]+\.[0-9]+\.[0-9]+")

if [ "$INSTALLED" == "$LATEST" ]
then
  echo "Node.js is current ($INSTALLED)"
  exit 0
fi

echo "Node.js is outdated ($INSTALLED installed, $LATEST latest)"

TARBALL="${TARBASE}.tar.xz"
URL="https://nodejs.org/dist/latest/${TARBALL}"
DIR="$HOME/Downloads"
LOCAL="$DIR/$TARBALL"
GLOBAL_PACKAGES=$(
  npm list --global --depth 0 --parseable 2>/dev/null \
  | grep node_modules | grep -Eo "/[^/]+$" \
  | cut -d/ -f2 | grep -vE "^npm$" | xargs echo)

echo "Downloading ${URL} to ${DIR}/"
curl "$URL" -o "$LOCAL"

echo "Extracting ${LOCAL}"
tar xf "$LOCAL" -C "$DIR"

echo "Moving old node to ~/node.bak"
if [[ -e ~/node ]]
then
  mv ~/node ~/node.bak
fi

echo "Moving new node to ~/node"
mv "$DIR/$TARBASE" ~/node

#echo "Updating npm"
#npm update npm --global

echo "Re-installing global packages: $GLOBAL_PACKAGES"
#npm install --global $GLOBAL_PACKAGES

echo "Deleting old node ~/node.bak"
rm -rf ~/node.bak

echo "Deleting new node tarball $LOCAL"
rm "$LOCAL"
