#!/usr/bin/env bash

# Change to the dir of this script
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "$DIR"

# Use passwd file for commands requiring sudo
if [ ! -r ./passwd ]; then
  echo "ERROR: Put your password in a file called 'passwd' in this script dir!"
  exit 1
fi

# arg must be 'cli' or 'gui'
if [ "$1" == 'cli' ]; then
  APPS=$(cat cli_installs)
elif [ "$1" == 'gui' ]; then
  APPS=$(cat cli_installs gui_installs | sed '/^$/d')
else
  echo "ERROR: First arg must be 'cli' or 'gui'"
  exit 1
fi

for app in $APPS; do
  sudo -S apt-get -y install "$app" < ./passwd
done


# add pwfeedback to sudoers.d
sudo -S bash -c 'echo "Defaults pwfeedback" > /etc/sudoers.d/pwfeedback' < ./passwd
sudo -S chmod 0440 /etc/sudoers.d/pwfeedback < ./passwd
