#!/bin/bash

# mv /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.old

{
  echo '##'
  echo '## Arch Linux repository mirrorlist'
  echo '## Generated on 2020-01-03'
  echo '##'
  echo
  echo '## Japan'
  echo 'Server = http://mirrors.cat.net/archlinux/$repo/os/$arch'
  echo 'Server = https://mirrors.cat.net/archlinux/$repo/os/$arch'
  echo 'Server = http://ftp.tsukuba.wide.ad.jp/Linux/archlinux/$repo/os/$arch'
  echo 'Server = http://ftp.jaist.ac.jp/pub/Linux/ArchLinux/$repo/os/$arch'
  echo 'Server = https://ftp.jaist.ac.jp/pub/Linux/ArchLinux/$repo/os/$arch'
  echo 'Server = https://jpn.mirror.pkgbuild.com/$repo/os/$arch'
} > /etc/pacman/d/mirrorlist

# Update database
pacman -Sy
if ! pacman -Sy; then
  echo "${0##*/}: Not updated database." >&1
  exit 16
fi

if ! pacman -S git expect; then
  echo "${0##*/}: Not installed necesary package." >&1
  exit 32
fi

if ! git clone https://github.com/toshiki670/linux_installer.git ~/installer; then
  echo "${0##*/}: Not cloned." >&1
  exit 64
fi

