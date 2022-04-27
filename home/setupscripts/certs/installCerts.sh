#!/usr/bin/env bash

print_sep "Installing certs"
# Copy the certs to this directory before running this script. 
# Or add the scripts and config to ~/.ssh later
mkdir -p ~/.ssh
cp -v ./certs/* ~/.ssh