#!/bin/bash

ln -sf /usr/share/zoneinfo/Asia/Tokyo /etc/localtime
q=$?; if [[ $q != 0 ]]; then exit $q;fi

hwclock --systohc --utc
exit $?

