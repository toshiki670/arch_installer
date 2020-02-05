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

append_hosts() {
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
  result=$?; if [[ $result != 0 ]]; then return $result;fi


  # Add Google DNS
  {
    echo 'nameserver 8.8.8.8'
    echo 'nameserver 8.8.4.4'
  } >> /etc/resolv.conf
  return $?
}
