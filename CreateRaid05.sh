#!/bin/bash


banner()
{
  echo "+------------------------------------------+"
  printf "| %-40s |\n" "`date`"
  echo "|                                          |"
  printf "|`tput bold` %-40s `tput sgr0`|\n" "$@"
  echo "+------------------------------------------+"
}





printf "|`tput bold` %-40s `tput sgr0`|\n" "Create Raid05  will create a raid 5 mdam file with all available disk  "
printf "|`tput bold` %-40s `tput sgr0`|\n" "default disk for RAID5 is : sdb  , sdc , sdd ,   "
printf "|`tput bold` %-40s `tput sgr0`|\n" "backup disk is sde   "

echo "-------------------------------------------------"
sleep 1 

    if [[ $(id -u) -ne 0 ]] ; then
        echo "This script should run as a root user "
        exit 1
    fi
DEVICE_LIST=("sdb" "sdc" "sdd")
printf "|`tput bold` %-40s `tput sgr0`|\n" " devices is : " ${DEVICE_LIST[@]}




echo -e "Creating Partitions.... "
   for i in ${DEVICE_LIST[@]};
   do 
     DEVICE=$i
     printf "|`tput bold` %-40s `tput sgr0`|\n" " create partition for /dev/" $i
     echo -e  "m\nn\np\n1\n\n\nw\n" | sudo fdisk /dev/$DEVICE
   done 
echo -e "Partitions Created "
lsblk	
printf "|`tput bold` %-40s `tput sgr0`|\n" "Now Create RAID 5 with 3 Partition "
sleep 2 
mdadm -C /dev/md0 -l 5 -n 3 /dev/${DEVICE_LIST[0]}1 /dev/${DEVICE_LIST[1]}1 /dev/${DEVICE_LIST[2]}1


printf "|`tput bold` %-40s `tput sgr0`|\n" "format the RAID file system , used ext4 in this section"

sleep 1 
mkfs.ext4 /dev/md0 
printf "|`tput bold` %-40s `tput sgr0`|\n" "Format completed , detail of RAID File is :"


mdadm --detail /dev/md0 
MOUNT_DIR=$(pwd)
MOUNT_DIR=$MOUNT_DIR"/mnt" 
printf "|`tput bold` %-40s `tput sgr0`|\n" "Create Directory to mount md0 RAID05"

sleep 1
  if [ -d "$MOUNT_DIR" ]; then
    echo "good , mount Directory already exist"
  else 
    echo "Directory does not exist" 
    echo "make mount Directory ... "
    mkdir mnt
  fi
printf "|`tput bold` %-40s `tput sgr0`|\n" "Mounting Directory .... "


sleep 1 
mount /dev/md0 mnt/
echo "check  disk of RAID mounted Or not ... "
CHECK_STATUS=$(df -h  | grep /dev/md0)

  if [ ! -z "$CHECK_STATUS" ]; then    
    banner "Mounted Directory "

  else 
    banner "Did not mount Direectory "

    exit 1 
  fi 

