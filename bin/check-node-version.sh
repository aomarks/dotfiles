#!/usr/bin/env bash

set -e

NODE_INSTALLED=$(node --version)

NODE_LATEST=$(curl --silent --show-error --fail \
  https://nodejs.org/dist/latest/SHASUMS256.txt \
  | grep linux-x64.tar.xz | grep -Eo "v[0-9]+\.[0-9]+\.[0-9]+")

if [ "$NODE_INSTALLED" == "$NODE_LATEST" ]
then echo "Node.js is current ($NODE_INSTALLED)"
else echo "Node.js is outdated ($NODE_INSTALLED installed, $NODE_LATEST latest)"; exit 1
fi
