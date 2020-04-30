#!/bin/bash


mkdir /etc/pacman.d/hooks


# systemd-boot
{
  echo '[Trigger]'
  echo 'Type = Package'
  echo 'Operation = Upgrade'
  echo 'Target = systemd'
  echo
  echo '[Action]'
  echo 'Description = Updating systemd-boot'
  echo 'When = PostTransaction'
  echo 'Exec = /usr/bin/bootctl update'
} >> /etc/pacman.d/hooks/systemd-boot.hook


# Nvidia
{
  echo '[Trigger]'
  echo 'Operation=Install'
  echo 'Operation=Upgrade'
  echo 'Operation=Remove'
  echo 'Type=Package'
  echo 'Target=nvidia'
  echo
  echo '[Action]'
  echo 'Depends=mkinitcpio'
  echo 'When=PostTransaction'
  echo 'Exec=/usr/bin/mkinitcpio -p linux'
} >> /etc/pacman.d/hooks/nvidia.hook

