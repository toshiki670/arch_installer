#!/bin/bash

source ./helper/checker.sh
source ./second/setting.sh


main() {

  set_timezone
  check_exit $? "Faild set timezone"

  set_locale
  check_exit $? "Faild set locale"

  set_hosts
  check_exit $? "Faild set hosts"

  set_network
  check_exit $? "Faild set network"

  set_initramfs
  check_exit $? "Faild set initramfs"

  set_boot_loader
  check_exit $? "Faild set boot loader"

  passwd
  check_exit $? "Faild set root password"

  add_user
  check_exit $? "Faild add user"
}


main
