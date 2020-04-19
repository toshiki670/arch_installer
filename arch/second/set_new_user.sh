#!/bin/bash


lsblk -p
read -p "Enter username:" username

useradd -m -G wheel $username
q=$?; if [[ $q != 0 ]]; then exit $q;fi

passwd $username
exit $?
