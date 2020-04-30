#!/bin/bash

source ./helper/checker.sh
source ./helper/chooser.sh


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

  sh ./first/format_boot.sh $boot_path
  check_exit $? "Faild boot format"

  sh ./first/lvm.sh $main_path
  check_exit $? "Faild lvm"

  sh ./first/mount.sh $boot_path
  check_exit $? "Faild mount"

  sh ./first/install_system.sh
  check_exit $? "Faild install"

  clone_installer
  check_exit $? "Faild clone"

  arch-chroot /mnt
  check_exit $? "Faild chroot"

  exit 0
}

clone_installer(){
  tag="0.3.0"
  repo_url="https://github.com/toshiki670/linux_installer.git"
  if ! git clone --branch ${tag} --single-branch ${repo_url} /mnt/root/installer; then
    echo "${0##*/}: Not cloned." 1>&2
    return 64
  fi
}


main
