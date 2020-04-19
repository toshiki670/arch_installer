#!/bin/bash

prefix="Linux"
length=8
hostname=`cat /dev/urandom | tr -dc "[:alnum:]" | fold -w $length | head -n 1 | sed "s/^/${prefix}-/"`

{
  echo '127.0.0.1 localhost'
  echo '::1       localhost'
  echo "127.0.1.1 ${hostname}.localdomain  ${hostname}"
} >> /etc/hosts
exit $?
