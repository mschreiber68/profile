#!/usr/bin/env bash

# Change to the dir of this script
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "$DIR"

# arg must be 'cli' or 'gui'
if [ "$1" == 'cli' ]; then
  APPS=$(cat cli_installs)
elif [ "$1" == 'gui' ]; then
  APPS=$(cat cli_installs gui_installs | sed '/^$/d')
else
  echo "ERROR: First arg must be 'cli' or 'gui'"
  exit 1
fi

sudo apt-get update && sudo apt-get upgrade
for app in $APPS; do
  sudo apt-get -y install "$app"
done


# add pwfeedback to sudoers.d
if [ ! -f /etc/sudoers.d/pwfeedback ]; then
  sudo bash -c 'echo "Defaults pwfeedback" > /etc/sudoers.d/pwfeedback'
  sudo chmod 0440 /etc/sudoers.d/pwfeedback
fi
