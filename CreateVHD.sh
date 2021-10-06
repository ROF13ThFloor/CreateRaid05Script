#!/bin/bash
VOLUME_NAME=$1
echo "-------------------------------------------------"
echo "Creating  VHD volume using dd "
sleep 1
dd if=/dev/zero of=$VOLUME_NAME".img" bs=1M count=1200
echo "-------------------------------------------------"
echo "Format volume to the ext4 "
sleep 1
mkfs -t ext4 $VOLUME_NAME".img"
echo "-------------------------------------------------"
echo "make mount directory for this volume "
sleep 1
mkdir /mnt/$VOLUME_NAME
echo "-------------------------------------------------"
sleep 1
echo "mount  volume to the directory"
sleep 1
mount -t auto -o loop $VOLUME_NAME".img" /mnt/$VOLUME_NAME"/"
echo "-------------------------------------------------"
echo "mounted directory ..... "
df -hT

lsblk
~                                                                                         
~                                                                                         
~                                                                                         
~                                                                                         
~                         