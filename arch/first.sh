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

  mount $boot_path
  check_exit $? "Faild mount"

  install_system
  check_exit $? "Faild install"
  
}

# format_boot 
#
# check_exit $? "Error mkfs.fat"


main
