#!/usr/bin/env bash

print_sep "Setting up mac"
# Close any open System Preferences panes, to prevent them from overriding
# settings we’re about to change
osascript -e 'tell application "System Preferences" to quit'

source ./mac/brew.sh
source ./mac/duti.sh
source ./mac/macos-config.sh

# setup vscode
print_sep "Configuring vscode"
mkdir -p "$HOME/Library/Application Support/Code/User"
cp -v ./mac/vscode.settings.json "$HOME/Library/Application Support/Code/User/settings.json"

#print_sep "Setting up fzf keybindings"
#/usr/local/opt/fzf/install

print_sep "Mac setup complete"
echo "Setup chrome as email handler in mail"
echo "Press Command + Shift + . to show all files in finder"
echo "Now open all the apps on Mac one by one to allow them to execute"