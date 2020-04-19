#!/bin/bash


bootctl --path=/boot install
q=$?; if [[ $q != 0 ]]; then exit $q;fi

crypto_uuid=`lsblk -Pfip |\
  grep 'crypto_LUKS' |\
  sed -r 's/[[:alnum:]]+=/\n&/g' |\
  awk -F= '$1=="UUID"{print $2}' |\
  sed 's/"//g'`

{
  echo 'title  Arch Linux'
  echo 'linux /vmlinuz-linux'
  echo 'initrd /initramfs-linux.img'
  echo 'options cryptdevice=UUID='${crypto_uuid}':decrypted root=/dev/mapper/system-root nvidia-drm.modeset=1 rw'
} >> /boot/loader/entries/arch.conf
exit $?
