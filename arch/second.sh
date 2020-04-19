#!/bin/bash

source ./helper/checker.sh


main() {

  ./second/set_timezone.sh
  check_exit $? "Faild set timezone"

  ./second/set_locale.sh
  check_exit $? "Faild set locale"

  ./second/set_hosts.sh
  check_exit $? "Faild set hosts"

  ./second/set_network.sh
  check_exit $? "Faild set network"

  ./second/set_initramfs.sh
  check_exit $? "Faild set initramfs"

  ./second/set_boot_loader.sh
  check_exit $? "Faild set boot loader"

  passwd
  check_exit $? "Faild set root password"

  ./second/set_new_user.sh
  check_exit $? "Faild add user"
}


main
