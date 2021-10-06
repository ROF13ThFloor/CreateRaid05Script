#!/bin/bash


banner()
{
  echo "+------------------------------------------+"
  printf "| %-40s |\n" "`date`"
  echo "|                                          |"
  printf "|`tput bold` %-40s `tput sgr0`|\n" "$@"
  echo "+------------------------------------------+"
}



    if [[ $(id -u) -ne 0 ]] ; then
        echo "This script should run as a root user "
        exit 1
    fi
printf "|`tput bold` %-40s `tput sgr0`|\n" "this Script Test that Raid05 work correctly or not"


sleep 1
echo "------------------------------"
printf "|`tput bold` %-40s `tput sgr0`|\n" "Test contain make simplae text file in mounted Directory by MD0 and then change the virtual Disks then test that data accessibility  by See File content"
sleep 3 
echo "------------------------------"
printf "|`tput bold` %-40s `tput sgr0`|\n" "changing Direcotry to mounted Directo"

MOUNTED_DIR="mnt/"
      if [ -f $MOUNTED_DIR"TestRaid05.txt" ]; then
         echo "File exist..... test started"
      else 
 	 echo "File does not Exist , creating File "
	 touch $MOUNTED_DIR"TestRaid05.txt"
	 cd $MOUNTED_DIR
	 echo "this file is created to test Raid05 accessibility after failed disk" >> TestRaid05.txt
	 cd .. 
      fi
echo "check /mnt content"
echo "------------------------------"

ls -la $MOUNTED_DIR
printf "|`tput bold` %-40s `tput sgr0`|\n" "now we should fail one partition and then replce with new for test RAID05 working"
sleep 1 
echo "------------------------------"

mdadm /dev/md0 -f /dev/sdb1
echo "checking Failed of sdb1..."
sleep 1 
echo "------------------------------"

mdadm --detail /dev/md0  
echo "checking mounted dir for see the data are corrupted or not"
ls -la $MOUNTED_DIR
echo "------------------------------"
printf "|`tput bold` %-40s `tput sgr0`|\n" "remove failed partiion and check File we crearte before"


mdadm /dev/md0 -r /dev/sdb1
sleep 1
echo "------------------------------"
 
lsblk | grep -A 10 sdb1
echo "------------------------------"
echo "Device removed "
echo "------------------------------"
lsblk 
echo "------------------------------"
echo "now i will replace removed disk by new disk  , before it we should partition new disk"
sleep 1
echo -e  "m\nn\np\n1\n\n\nw\n" | sudo fdisk /dev/sde 
echo "------------------------------"
echo "lsblk show that new disk partition"
lsblk 
echo "Format to ext4 (new disk partition)"
mkfs.ext4 /dev/sde1 
echo "------------------------------"
printf "|`tput bold` %-40s `tput sgr0`|\n" "add new partition  of new disk to our RAID"

mdadm /dev/md0 --add /dev/sde1
echo "------------------------------"
echo "show detail"
mdadm --detail /dev/md0 

echo "------------------------------"
printf "|`tput bold` %-40s `tput sgr0`|\n" "we can see file that we created before does not damaged"
ls -la $MOUNTED_DIR
cat $MOUNTED_DIR"TestRaid05.txt"
echo "------------------------------"

banner "RAID05 work fine "

