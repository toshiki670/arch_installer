#!/bin/bash

# It's not necessary to running as root.
if [[ ${EUID:-${UID}} -eq 0 ]]; then
  echo "${CMDNAME}: Running this script as root is no supported." 1>&2
  exit 1
fi


# Check installed the required shell.
if ! type "git" > /dev/null 2>&1; then
  echo "${CMDNAME}: Git command not found." 1>&2
  exit 8
fi

git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
cd ..
rm -rf yay


# For mkinitcpio
yay -S aic94xx-firmware
yay -S wd719x-firmware
