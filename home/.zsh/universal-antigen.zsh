#!/usr/bin/env bash

# Load the oh-my-zsh's library.
antigen use oh-my-zsh

# Bundles from the default repo (robbyrussell's oh-my-zsh).
antigen bundle npm
antigen bundle node
antigen bundle macos
antigen bundle thefuck
antigen bundle z
antigen bundle git
antigen bundle isodate
antigen bundle history

# Syntax highlighting bundle.
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-completions
antigen bundle zsh-users/zsh-syntax-highlighting

# Syntax highlighting bundle.
antigen bundle unixorn/git-extra-commands@main

# Load the theme.
antigen bundle sindresorhus/pure@main

# Tell Antigen that you're done.
antigen apply