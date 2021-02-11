#!/usr/bin/env bash

sudo apt update | tee /dev/stderr | grep -q "All packages are up to date"
APT_CODE=$?
apt list --upgradable
echo

check-node-version.sh
NODE_CODE=$?
echo

npm --global outdated | tee /dev/stderr | grep -q "Wanted"
NPM_CODE=$?
echo

RED="\u001b[31m"
GREEN="\u001b[32m"
RESET="\u001b[0m"

EXITCODE=0

if [[ $APT_CODE == 0 ]]
then echo -e "[${GREEN}OK${RESET}] APT"
else echo -e "[${RED}!!${RESET}] APT (sudo apt upgrade)"; EXITCODE=1
fi

if [[ $NODE_CODE == 0 ]]
then echo -e "[${GREEN}OK${RESET}] Node.js"
else echo -e "[${RED}!!${RESET}] Node.js (update-node-version.sh)"; EXITCODE=1
fi

if [[ $NPM_CODE != 0 ]]
then echo -e "[${GREEN}OK${RESET}] NPM"
else echo -e "[${RED}!!${RESET}] NPM (npm --global update)"; EXITCODE=1
fi

exit $EXITCODE
