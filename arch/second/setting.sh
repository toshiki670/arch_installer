#!/bin/bash

set_timezone() {
  ln -sf /usr/share/zoneinfo/Asia/Tokyo /etc/localtime
  q=$?; if [[ $q != 0 ]]; then return $q;fi

  hwclock --systohc --utc
  return $?
}

set_locale() {
  vim /etc/locale.gen
  q=$?; if [[ $q != 0 ]]; then return $q;fi

  locale-gen
  return $?
}

set_hosts() {
  prefix="Linux"
  length=8
  hostname=`cat /dev/urandom | tr -dc "[:alnum:]" | fold -w $length | head -n 1 | sed "s/^/${prefix}-/"`

  {
    echo '127.0.0.1 localhost'
    echo '::1       localhost'
    echo "127.0.1.1 ${hostname}.localdomain  ${hostname}"
  } >> /etc/hosts
  return $?
}

set_network() {
  systemctl enable dhcpcd
  q=$?; if [[ $q != 0 ]]; then return $q;fi


  # Add Google DNS
  {
    echo 'nameserver 8.8.8.8'
    echo 'nameserver 8.8.4.4'
  } >> /etc/resolv.conf
  return $?
}

set_initramfs() {
  {
    echo '# MODULES=(nvidia nvidia_modeset nvidia_uvm nvidia_drm)'
    echo '# HOOKS=(base udev autodetect modconf keyboard keymap block encrypt lvm2 filesystems fsck)'
  } >> /etc/mkinitcpio.conf
  q=$?; if [[ $q != 0 ]]; then return $q;fi

  vim /etc/mkinitcpio.conf
  q=$?; if [[ $q != 0 ]]; then return $q;fi

  mkinitcpio -p linux
  return $?
}

set_boot_loader() {
  bootctl --path=/boot install
  q=$?; if [[ $q != 0 ]]; then return $q;fi

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
  return $?
}

add_user() {
  lsblk -p
  read -p "Enter username:" username

  useradd -m -G wheel $username
  q=$?; if [[ $q != 0 ]]; then return $q;fi

  passwd $username
  return $?
}

set_sudoer() {
  echo "Enable wheel group as sudoer."
  echo "Uncomment the below:"
  echo "# %wheel ALL=(ALL) ALL"
  echo
  read -p "Press enter to continue"

  visudo
  return $?
}
