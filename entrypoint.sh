#!/bin/sh

echo "EFI_DEV_NAME: $EFI_DEV_NAME"

# only run this if $EFI_DEV_NAME is populated
if [ ! -z "$EFI_DEV_NAME" ]; then
  for num in $(efibootmgr |grep "$EFI_DEV_NAME" | cut -d " " -f1| cut -d"t" -f2 | cut -d"*" -f1); do
    echo "deleting device: $num"
    efibootmgr --delete-bootnum --bootnum $num
  done
else
  echo "env var EFI_DEV_NAME is not set. Must be set in order to clean up EFI boot devices."
fi

echo "WIPE_DISK: $WIPE_DISK"
echo "DISK_DEV: $DISK_DEV"

if [ ! -z "$WIPE_DISK" ] && [ ! -z "$DISK_DEV" ]; then
  echo "not implemented yet"
else
  echo "env vars WIPE_DISK or DISK_DEV are not set. Both of these must be set in order to wipe a disk."
fi
