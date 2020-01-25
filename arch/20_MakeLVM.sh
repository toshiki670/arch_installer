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


cryptsetup -v -c serpent-xts-plain64 -s 512 -h sha512 luksFormat ${path}
cryptsetup luksOpen ${path} decrypted
pvcreate /dev/mapper/decrypted
vgcreate system /dev/mapper/decrypted
lvcreate -L 50G system -n root
lvcreate -l 100%FREE system -n home

mkfs.xfs /dev/mapper/system-root
mkfs.xfs /dev/mapper/system-home

