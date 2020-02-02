#!/bin/bash

path=$1

lvm_on_luks(){
  if [[ $# != 1 ]]; then
    echo "${0##*/}: Requires 1 argument." >&1
    exit 16
  fi

  if [[ ! -b ${path} ]]; then
    echo "${0##*/}: $1 isn't a device file." >&1
    exit 32
  fi


  cryptsetup -v -c serpent-xts-plain64 -s 512 -h sha512 luksFormat ${path}
  result=$?; if [[ $result != 0 ]]; then return $result;fi

  cryptsetup luksOpen ${path} decrypted
  result=$?; if [[ $result != 0 ]]; then return $result;fi

  pvcreate /dev/mapper/decrypted

  result=$?; if [[ $result != 0 ]]; then return $result;fi

  vgcreate system /dev/mapper/decrypted
  result=$?; if [[ $result != 0 ]]; then return $result;fi

  lvcreate -l 100%FREE system -n root
  result=$?; if [[ $result != 0 ]]; then return $result;fi


  # For next version
  # lvcreate -L 50G system -n root
  # lvcreate -l 100%FREE system -n home

  mkfs.xfs /dev/mapper/system-root
  result=$?; if [[ $result != 0 ]]; then return $result;fi

  # mkfs.xfs /dev/mapper/system-home
}
