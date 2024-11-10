#!/bin/sh

# Error mounting /dev/... /media/
# Wrong  fs type

sudo fdisk -l
sudo apt install nfs-common
sudo apt install cifs-utils
sudo apt-get install ntfs-3g
sudo ntfsfix -d [volume] # Ex: /dev/sba1

