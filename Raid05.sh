#!/bin/bash


echo -e "\033[1mCreate Raid05  will create a raid 5 mdam volume with all available devices and "
sleep 1 

    if [[ $(id -u) -ne 0 ]] ; then
        echo "This script should run as a root user "
        exit 1
    fi
DEVICE_LIST=("sdb" "sdc" "sdd")
echo -e "\033[1mdevices is : " ${DEVICE_LIST[@]}


echo -e "\033[1mCreating Partitions.... "
   # for i in ${DEVICE_LIST[@]};
   # do 
   #   DEVICE=$i
   #   echo "Creating Partition for /dev/" $i 
   #   echo -e  "m\nn\np\n1\n\n\nw\n" | sudo fdisk /dev/$DEVICE
   # done 
echo -e "\033[1mPartitions Created "
lsblk	
echo -e "\033[1mNow Create RAID 5 with 3 Partition " 
sleep 2 
#mdadm -C /dev/md0 -l 5 -n 3 /dev/${DEVICE_LIST[0]}1 /dev/${DEVICE_LIST[1]}1 /dev/${DEVICE_LIST[2]}1

echo -e "\033[1mformat the RAID file system , used ext4 in this section"
sleep 1 
#mkfs.ext4 /dev/md0 
echo -e "\033[1mFormat completed , detail of RAID File is : "

#mdadm --detail /dev/md0 
MOUNT_DIR=$(pwd)
MOUNT_DIR=$MOUNT_DIR"/mnt" 
echo "Create Directory to mount md0 RAID05"
sleep 1
  if [ -d "$MOUNT_DIR" ]; then
    echo "good , mount Directory already exist"
  else 
    echo "Directory does not exist" 
    echo "make mount Directory ... "
    mkdir mnt
  fi
echo -e "\033[1mMounting Directory .... "
sleep 1 
#mount /dev/md0 mnt/
echo "check  disk of RAID mounted Or not ... "
CHECK_STATUS=$(df -h  | grep /dev/md0) 
   if [ ! -z "$CHECK_STATUS" ]; then 
     echo "mounted successfully :) "
   else 
     echo "did not mount successfully "
     exit 1 
   fi 

