#!/bin/bash

set_timezone() {
  ln -sf /usr/share/zoneinfo/Asia/Tokyo /etc/localtime
  result=$?; if [[ $result != 0 ]]; then return $result;fi

  hwclock --systohc --utc
  return $?
}

set_locale() {
  vim /etc/locale.gen
  result=$?; if [[ $result != 0 ]]; then return $result;fi

  locale-gen
  return $?
}

