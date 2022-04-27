#!/usr/bin/env bash

# needed for qlvideo
sudo softwareupdate --install-rosetta

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
print_sep "Installing brew packages"

replaceLine='eval "$(brew shellenv)"'
if grep --quiet "$replaceLine" "/Users/$(whoami)/.zprofile"; then
 echo "Brew shell already setup"
else
   echo "Adding brew shell to .zprofile ($replaceLine)"
   sudo -- sh -c -e "echo '$replaceLine' >> /Users/$(whoami)/.zprofile";
fi

eval "$(brew shellenv)"
brew tap homebrew/cask-fonts
brew update

# You may be asked for user name and password for github when install brew packages
# You can add an env variable for a (read only) github api key
# as HOMEBREW_GITHUB_API_TOKEN=

# GNU core utilities (those that come with OS X are outdated)
brew install coreutils
brew install moreutils
# GNU `find`, `locate`, `updatedb`, and `xargs`, `g`-prefixed
brew install findutils
# GNU `sed`
brew install gnu-sed
brew install homeshick
brew install antigen
brew install thefuck
brew install git
brew install zsh
brew install node
brew install duti
brew install fzf
brew install fx
brew install bat
brew install duf
brew install exa
brew install ripgrep
brew install diff-so-fancy
brew install betterzip
brew install sqlite
brew install openssl
brew install awscli
brew install imagemagick
brew install youtube-dl
brew install jq
brew install azure-cli
brew install terraform
brew install helm
brew install kubectl
brew install tree
brew install pandoc
# used to configure custom keyboards. long install time so uncomment only if you use qmk
# brew install qmk/qmk/qmk
brew install trash
brew install wget
brew install typescript
brew install gh
brew install openjdk
brew install --cask font-hack-nerd-font

## -----------------------------------------------
## feel free to remove some of these below if you like
brew install --cask visual-studio-code
brew install --cask macdown
brew install --cask notion
brew install --cask deckset
brew install --cask ImageOptim
brew install --cask screenflow
brew install --cask caffeine
brew install --cask flux
brew install --cask muzzle
brew install --cask scroll-reverser
brew install --cask qlcolorcode
brew install --cask qlstephen
brew install --cask qlmarkdown
brew install --cask quicklook-json
brew install --cask epubquicklook
brew install --cask quicklook-csv
brew install --cask qlimagesize
brew install --cask suspicious-package
brew install --cask apparency
brew install --cask quicklookase
brew install --cask qlvideo
brew install --cask vlc
brew install --cask google-chrome
brew install --cask firefox
brew install --cask alfred
brew install --cask slack
brew install --cask gimp
brew install --cask telegram
brew install --cask muzzle
brew install --cask beyond-compare
brew install --cask rectangle
brew install --cask iterm2
brew install --cask postico
brew install --cask figma
brew install --cask zoom
brew install --cask spotify
brew install --cask sourcetree
brew cleanup

# symlink java
sudo ln -sfn /opt/homebrew/opt/openjdk/libexec/openjdk.jdk /Library/Java/JavaVirtualMachines/openjdk.jdk

# install nvm
print_sep "installing nvm"
if ! [ -s "$HOME/.nvm/nvm.sh" ]; then
    echo "installing nvm"
    wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
    echo "you can remove the nvm lines that were added to your .zshrc if you want to keep that file clean."
    echo "they are already in custom.zsh"
 else
    echo "nvm detected - skipping nvm install"
 fi
