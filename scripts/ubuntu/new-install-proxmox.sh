#!/bin/bash

# Notice: ensure QEMU is enabled on the proxmox VM

sudo apt update
sudo apt dist-upgrade
sudo apt install qemu-guest-agent -y

STATUS="$(systemctl is-active qemu-guest-agent.service)"
if [ "${STATUS}" = "active" ]; then
    echo "Basic setup complete."
    exit 1
else 
    echo "qemu-gest-agent service not running... attempting to start"  
    sudo systemctl start qemu-guest-agent.service
fi