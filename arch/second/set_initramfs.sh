#!/bin/bash

{
  echo '# MODULES=(nvidia nvidia_modeset nvidia_uvm nvidia_drm)'
  echo '# HOOKS=(base udev autodetect modconf keyboard keymap block encrypt lvm2 filesystems fsck)'
} >> /etc/mkinitcpio.conf
q=$?; if [[ $q != 0 ]]; then exit $q;fi

vim /etc/mkinitcpio.conf
q=$?; if [[ $q != 0 ]]; then exit $q;fi

mkinitcpio -p linux
exit $?
