#!/bin/bash

systemctl enable dhcpcd
q=$?; if [[ $q != 0 ]]; then exit $q;fi


# Add Google DNS
{
  echo 'nameserver 8.8.8.8'
  echo 'nameserver 8.8.4.4'
} >> /etc/resolv.conf
exit $?
