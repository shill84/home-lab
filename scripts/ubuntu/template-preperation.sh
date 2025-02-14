#!/bin/bash

# clear ssh keys
sudo rm /etc/ssh/ssh_host_*

# clear machine id
sudo truncate -s 0 /etc/machine-id

# check if the machine-id is a symlink
ls -l /var/lib/dbus/machine-id

# clean up
sudo apt clean
sudo apt autoremove