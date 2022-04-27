#!/usr/bin/env bash

print_sep "Updating ubuntu"
# allow normal updates
sudo sed -i 's/prompt=lts/prompt=normal/g' /etc/update-manager/release-upgrades
# update all packages
sudo apt update && sudo apt upgrade

# this package breaks the Ubuntu upgrade process on WSL so remove it
sudo apt remove snapd
sudo do-release-upgrade

print_sep "Installing zsh and friends"
# install zsh
sudo apt install zsh && chsh -s $(which zsh)
# install antigen
curl -L git.io/antigen > antigen.zsh

sudo apt install -y fonts-hack-ttf
sudo apt install -y exa
sudo apt install -y fzf
sudo apt install -y sqlite3
sudo apt install -y git
sudo apt install -y bat
sudo apt install -y ripgrep
sudo apt install -y openssl
sudo apt install -y jq
sudo apt install -y curl
sudo apt install python3-dev python3-pip python3-setuptools

# pip tools
pip3 install thefuck --user

# homeshick
print_sep "installing homeshick"
git clone https://github.com/andsens/homeshick.git $HOME/.homesick/repos/homeshick

# helm
print_sep "installing helm"
curl https://baltocdn.com/helm/signing.asc | sudo apt-key add -
sudo apt-get install apt-transport-https --yes
echo "deb https://baltocdn.com/helm/stable/debian/ all main" | sudo tee /etc/apt/sources.list.d/helm-stable-debian.list
sudo apt-get update
sudo apt-get install helm

#Azure cli
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash

# nvm and nodejs
print_sep "installing nvm"
if ! [ -s "$HOME/.nvm/nvm.sh" ]; then
    echo "installing nvm"
    wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
    echo "you can remove the nvm lines that were added to your .zshrc if you want to keep that file clean."
    echo "they are already in custom.zsh"
 else
    echo "nvm detected - skipping nvm install"
 fi
 
. "$HOME/.nvm/nvm.sh"
nvm install 14

# other npm tools
npm install -g fx
npm i -g diff-so-fancy
npm i -g typescript

# install vscode settings
print_sep "Copying vscode settings"
[ -d "/mnt/c/Users/$(whoami)/AppData/Roaming/Code/User"] && cp -v ./wsl-ubuntu/vscode.settings.json "/mnt/c/Users/$(whoami)/AppData/Roaming/Code/User/settings.json"
[ -d "$HOME/.config/Code/User"] && cp -v ./wsl-ubuntu/vscode.settings.json "$HOME/.config/Code/User/settings.json"

print_sep "Finished windows setup"
echo "install the hack font on windows itself from - https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts/Hack"