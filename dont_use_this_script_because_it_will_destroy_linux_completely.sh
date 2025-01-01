#!/bin/bash
# Warning: This script will erase all data and cannot be undone.

# Wipe logs
sudo rm -rf /var/log/*

# Wipe user directories
sudo rm -rf /home/*

# Wipe system files
sudo rm -rf /etc/*
sudo rm -rf /root/*

# Wipe temporary files
sudo rm -rf /tmp/*
sudo rm -rf /var/tmp/*
sudo rm -rf /var/cache/*

# Wipe the entire disk (use with caution, this will erase everything)
sudo dd if=/dev/zero of=/dev/sda bs=1M status=progress

# Optional: Repartition the disk (this is destructive and irreversible)
sudo fdisk /dev/sda

# Optionally wipe the disk securely
sudo shred -v -n 3 /dev/sda
