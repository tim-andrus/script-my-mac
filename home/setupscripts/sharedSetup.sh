#!/usr/bin/env bash
  
function print_sep {
  printf "\n\n"
  echo "###############################################################################"
  echo "$1"
  echo "###############################################################################"
}
  
echo "Make sure you've already added your github certs and config to the certs folder"
echo "Make sure you have added any github repos to be cloned to cloneRepos.sh"
read -p "Press any key to continue or ctrl-c to quit and do the steps above... " -n1 -s

print_sep "Email address and name for git"
echo "Please enter your email address for git"
read GIT_H_EMAIL_ADDRESS
echo "GIT_H_EMAIL_ADDRESS is set to $GIT_H_EMAIL_ADDRESS"
echo "Please enter your name for git"
read GIT_H_NAME
echo "GIT_H_NAME is set to $GIT_H_NAME"

print_sep "Getting sudo"
# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &
print_sep "Checking OS"
if [ "$(uname)" = "Darwin" ]; then
  echo "Running Mac OS setup."
  echo "Brew will ask you for a github login, you may be asked for sudo also."
  source ./mac/macSetup.sh
else
  # assume linux wsl on windows
  echo "Running linux setup."
  source ./wsl-ubuntu/windows-wsl-setup.sh
fi

print_sep "Configuring git"
# Add git code review commands
git config --global alias.cr-master '!git difftool --dir-diff origin/master..$1'
git config --global alias.cr-main '!git difftool --dir-diff origin/main..$1'

# Setup git
git config --global user.name "$GIT_H_NAME"
git config --global user.email "$GIT_H_EMAIL_ADDRESS"
git config --global alias.cm 'commit -m'
git config --global alias.cp 'cherry-pick -x'
git config --global alias.d 'diff'
git config --global alias.dc 'diff --cached'
git config --global alias.dlast 'diff HEAD^'
git config --global alias.l "log --graph -n 20 --pretty=format:'%C(yellow)%h%C(cyan)%d%Creset %s %C(green)- %an, %cr%Creset'"
git config --global alias.ll "log --stat --abbrev-commit"
git config --global alias.ln "log --graph -n 20 --pretty=format:'%C(yellow)%h%C(cyan)%d%Creset %s %C(green)- %an, %cr%Creset' --name-status"
git config --global alias.lp "log --oneline -n 20 -p"
git config --global alias.ls "log --stat --abbrev-commit -n 1" # display previous log
git config --global alias.st 'status -s'
git config --global alias.unstage 'reset HEAD --'
git config --global alias.uncommit 'reset --soft HEAD^'
# set fast autocorrect
git config --global help.autocorrect 2
# only push current branch
git config --global push.default current
git config --global web.browser "open"

git config --global pull.ff only
git config --global color.ui true
git config --global color.diff-highlight.oldNormal    "red bold"
git config --global color.diff-highlight.oldHighlight "red bold 52"
git config --global color.diff-highlight.newNormal    "green bold"
git config --global color.diff-highlight.newHighlight "green bold 22"
git config --global color.diff.meta       "11"
git config --global color.diff.frag       "magenta bold"
git config --global color.diff.func       "146 bold"
git config --global color.diff.commit     "yellow bold"
git config --global color.diff.old        "red bold"
git config --global color.diff.new        "green bold"
git config --global color.diff.whitespace "red reverse"
git config --global core.pager "diff-so-fancy | less --tabs=4 -RFX"
git config --global interactive.diffFilter "diff-so-fancy --patch"

# Preset global git config for beyond compare
git config --global diff.tool bc3
git config --global difftool.bc3.trustExitCode true
git config --global merge.tool bc3
git config --global mergetool.bc3.trustExitCode true

print_sep "Setting host"
replaceLine="127.0.0.1 host.docker.internal"
if grep --quiet "$replaceLine" /etc/hosts; then
 echo "Docker host already added to /etc/hosts"
else
   echo "Adding Docker host to /etc/hosts"
    sudo -- sh -c -e "echo '$replaceLine' >> /etc/hosts";
fi
print_sep "installing vscode extensions..."
# vscode extensions i use all the time
code --install-extension bradlc.vscode-tailwindcss
code --install-extension dbaeumer.vscode-eslint
code --install-extension esbenp.prettier-vscode
code --install-extension hediet.vscode-drawio
code --install-extension mikestead.dotenv
code --install-extension redhat.vscode-xml
code --install-extension streetsidesoftware.code-spell-checker
# Comment/uncomment for copilot. You probably don't want to install this at work or if you arent on the program
code --install-extension GitHub.copilot

source ./certs/installCerts.sh
source ./cloneRepos.sh

print_sep "Finished all"
printf "\n"
echo "DON'T FORGET THESE MANUAL STEPS"
printf "\n"
echo "configure homeshick and your dotfiles to use your own repo with the following commands:"
echo "homeshick clone yourgithub/your-repo"
echo "homeshick link your-repo"
printf "\n"
echo "Set your DNS to 8.8.8.8 to stop DNS lookup errors"
echo "Add an npm token to the ~/.npmrc that was created if publishing from this machine"
echo "use ssh-add -K ~/.ssh/[your-private-key] to permenantly add private keys to keychain/ssh-agent"
echo "Open beyond compare and install cli tools if using beyond compare"
echo "Install one note here or the app store: https://www.onenote.com/download"
printf "\n"
echo "Restart the machine!"