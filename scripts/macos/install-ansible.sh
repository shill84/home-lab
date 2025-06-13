#!/bin/bash
# Install Ansible on macOS
# This script installs Ansible using Homebrew and pipx.
# It also ensures that pipx is in the PATH.

# Check if pipx is in the PATH
if ! command -v pipx &> /dev/null
then
    echo "pipx could not be found. Attepting to install it now."
    brew install pipx
    pipx ensurepath
    #pipx ensurepath --global
fi 

if ! command -v ansible &> /dev/null
then
    echo "ansible could not be found. Attepting to install it now."
    pipx install --include-deps ansible
    pipx install ansible-core
fi