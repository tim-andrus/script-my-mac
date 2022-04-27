# My MacOS and Windows WSL setup scripts and dotfiles

## Overview

This is a set of scripts to configure a \*nix computer.

It's mostly MacOS but I also use it to configure WSL on windows.

On a mac it will do everything. On WSL it sets up CLI tools and prompt only.

The setup script should be repeatable without causing any issues. It works on my machine(s).

However - These scripts are designed for NEW machines. If you try to install it on an existing machine there might be conflict issues where I use brew and the existing install is another method.

## What the setup scripts will do

The setup scripts will perform the following:

- install rosetta
- install XCode command line tools
- install homebrew
- install 60 tools and apps that i use from homebrew
- install nvm
- assign all text-like files to vscode
- heaps of updates to default OS operation such as
  - Display full POSIX path as Finder window title
  - Keep folders on top when sorting by name
  - Avoid creating .DS_Store files on network or USB volumes
  - Enable snap-to-grid for icons on the desktop and in other icon views
  - Finder: show all filename extensions
  - Save to disk (not to iCloud) by default
  - Disable the warning when changing a file extension
  - Prevent Photos from opening automatically when devices are plugged in
- setup github
- set difftool to bcompare
- install the pure terminal prompt
- install the "Hack" nerd font
- install latest version of zsh
- install oh my zsh
- write my preferred oh my zsh configuration and aliases with antigen
- use homeshick to manage dotfiles
- add docker local url to hosts
- install vscode settings and extensions
- symlink brew java for macos
- clone my personal repositories from github
- post a bunch of reminders for manual steps to take to finish configuring the computer

Scripts are inspired by this and others: https://github.com/mathiasbynens/dotfiles/blob/main/.macos

## Step 1 - Store the files you received in a github repo

The first step is to create a new repository on your own github and put these files in it.

You will likely make a few changes to customise the configuration for your own preferences.

Homeshick will need a github repo to store and manage your dotfiles.

Do this now - add the files to a repo on your github so they're ready for your next new computer!

## Preparation steps on a brand new Mac

1. I open Safari and download chrome
1. I set that up manually because i need to get my ssh certs and the setup scripts from the web
1. On newer versions of MacOS you have to give your terminal application "Full Disk Access" in the privacy section of system preferences before starting.

## Preparation steps on a brand new Windows WSL2 machine

1. For WSL you need to have WSL 2+ and Ubuntu installed.

## Preparation steps to run the script

1. Review the list of software that will be installed in `brew.sh`. Most of the terminal apps are needed for scripts and aliases. I recommended leaving those in place. Delete or add any of the GUI applications ("casks") as you like.
1. For ssl certs if you put your certs and config in the `setupscripts/certs` folder before running `setupscripts/sharedSetup.sh` they will be put in "~/.ssh" for you. If this folder is empty we will only try to create the `~/.ssh` folder for you and you can put your certs in later. It goes without saying, but if you're forking this repo, do not ever put your certs in github.
1. Add a list of github repos to clone in the `cloneRepos.sh` file. These will be cloned after installing your certs.

## Running the script

1. Run the `home/setupscripts/sharedSetup.sh` script from the `setupscripts` directory to set up everything else. This is script works on Windows and MacOS. It will detect the OS automatically.
   e.g. `cd home/setupscripts && ./sharedSetup.sh`
   If you try to run the script from outside of this folder some of the references to other scripts may break.
1. You will be asked for your github email and username as part of the setup. This is for configuring the global git user
1. On MacOS If the script is failing you might need to `chmod +x sharedSetup.sh`. Alternatively you might need to remove the quarantine - `xattr -d com.apple.quarantine /PATH/TO/SCRIPTYOUCANTRUN.sh` for each one.

Scripts might fail in parts due to existing conflicts, or if MacOS has changed something in your version, from the version I test on.

If a script fails you can manually run each part from where it broke by copying and pasting the remaining commands.

Also, the scripts are designed to be safely repeatable so you can start from the start if you resolve the reason a script had issues.

## Now setup your terminal!

1. Run `homeshick clone your/githubrepo.git`. This is the repo with the files from this pack that you created in step 1 of this file.
1. It should ask you to link your dotfiles if it's the first time running so press `y`.
1. Get a new terminal, restart the terminal or you could open iterm now. Antigen should start installing plugins.
1. You should set the font for the terminal to "Hack Nerd Font" or "Hack" font family so that icons work as expected.

## After installing

1. I print out a list of suggested manual steps after the scripts have run. You don't have to do these. It's just things that I usually do!
1. Any of the GUI apps installed with brew will need to be opened once in MacOS to "allow running downloaded apps" before they will get indexed in finder or Alfred - I usually go through all of them in one go and open them.
1. Docker desktop seems to be better when installed from the download on the docker site - https://docs.docker.com/get-docker/
1. Microsoft One Note is the same. Better to get from the site than from homebrew - https://www.onenote.com/download
1. I use beyond compare as a visual diff tool for git, but it requires a licence. You can change git to use any visual difftool you like with

```shell
git config --global diff.tool bc3
git config --global difftool.bc3.trustExitCode true
git config --global merge.tool bc3
git config --global mergetool.bc3.trustExitCode true
```

Windows WSL notes

1. I use Ubuntu on WSL.
1. Homebrew etc obviously won't work on mac. But you use the same script `home/setupscripts/sharedSetup.sh` on windows. It will detect the OS and use apt where possible to install terminal tooling.
1. All the cli tools that work on WSL are installed and the prompt looks and works very similar to the MacOs prompt. Aliases replicate MacOS usage where possible. This is the point of this script.
