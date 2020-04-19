#!/bin/bash

if [[ $# != 1 ]]; then
  echo "${0##*/}: Requires 1 argument." 1>&2
  exit 16
fi

if [[ ! -b $1 ]]; then
  echo "${0##*/}: $1 isn't a device file." 1>&2
  exit 32
fi


mount /dev/mapper/system-root /mnt
q=$?; if [[ $q != 0 ]]; then exit $q;fi

mkdir /mnt/boot
# mkdir /mnt/boot /mnt/home
q=$?; if [[ $q != 0 ]]; then exit $q;fi

mount $1 /mnt/boot
# mount /dev/mapper/system-home /mnt/home
q=$?; if [[ $q != 0 ]]; then exit $q;fi

exit 0
