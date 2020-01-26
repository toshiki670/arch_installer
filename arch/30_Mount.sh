#!/bin/bash

path=$1

if [[ $# != 1 ]]; then
  echo "${0##*/}: Requires 1 argument." >&1
  exit 16
fi

if [[ ! -b ${path} ]]; then
  echo "${0##*/}: $1 isn't a device file." >&1
  exit 32
fi


mount /dev/mapper/system-root /mnt
mkdir /mnt/boot /mnt/home
mount ${path} /mnt/boot
mount /dev/mapper/system-home /mnt/home

