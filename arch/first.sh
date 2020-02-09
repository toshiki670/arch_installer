#!/bin/bash

source ./helper/checker.sh
source ./helper/chooser.sh

source ./first/boot_format.sh
source ./first/install_system.sh
source ./first/lvm.sh
source ./first/mount.sh


main() {

  lsblk -p
  read -p "Choose Install drive:" root_path

  # Make partition
  # TODO: Expectのインストール済みチェックや、引数チェックのプログラムを実装する必要がある。
  # TODO: イメージは中間処理を実装し、そこで引数チェックを行う。
  expect ./first/pertition.exp $root_path
  check_exit $? "Faild partition"

  lsblk -p
  read -p "Choose boot drive:" boot_path
  read -p "Choose main drive:" main_path

  format_boot $boot_path 
  check_exit $? "Faild boot format"

  lvm_on_luks $main_path
  check_exit $? "Faild lvm"

  mount_system $boot_path
  check_exit $? "Faild mount"

  install_system
  check_exit $? "Faild install"

  clone_installer
  check_exit $? "Faild clone"

  arch-chroot /mnt
  check_exit $? "Faild chroot"

  exit 0
}

clone_installer(){
  tag="0.1.1"
  repo_url="https://github.com/toshiki670/linux_installer.git"
  if ! git clone --branch ${tag} --single-branch ${repo_url} /mnt/root/installer; then
    echo "${0##*/}: Not cloned." >&1
    return 64
  fi
}


main
