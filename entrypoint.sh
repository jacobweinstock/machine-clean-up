#!/bin/sh


echo "EFI_DEV_NAME: $EFI_DEV_NAME"

# only run this if $EFI_DEV_NAME is populated
if [ ! -z "$EFI_DEV_NAME" ]; then
  for num in $(efibootmgr |grep "$EFI_DEV_NAME" | cut -d " " -f1| cut -d"t" -f2 | cut -d"*" -f1); do
    echo "deleting EFI boot device: $num"
    efibootmgr --delete-bootnum --bootnum $num
  done
else
  echo "env var EFI_DEV_NAME is not set. Must be set in order to clean up EFI boot devices."
fi

echo "DISK_DEVICES: $DISK_DEVICES"
echo "DISK_DEVICES format should be: DISK_DEVICES=(/dev/sda /dev/nvme0n1 /dev/nvme1n1)"

if [ ! -z "$DISK_DEVICES" ]; then
  for disk in "${DISK_DEVICES[@]}"; do
    blkdiscard -f "$disk" || wipefs -a "$disk"
  done
else
  echo "env var DISK_DEVICES is not set. Must be set in order to wipe additional disks."
fi
