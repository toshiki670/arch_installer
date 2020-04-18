#!/bin/bash

replace_mirrorlist(){
  mv /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.old
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
  } > /etc/pacman.d/mirrorlist
}


add_package() {
  packages=(
    "git"
    "expect"
  )
  if ! pacman -Sy ${packages[@]}; then
    echo "${0##*/}: Not installed necesary package." 1>&2
    exit 32
  fi
}


clone_installer(){
  tag="0.2.0"
  repo_url="https://github.com/toshiki670/linux_installer.git"
  if ! git clone --branch ${tag} --single-branch ${repo_url} ~/installer; then
    echo "${0##*/}: Not cloned." 1>&2
    exit 64
  fi
}


options(){
  # Time & date
  if ! timedatectl set-ntp true; then
    echo "${0##*/}: NTP enabled failed." 1>&2
    exit 128
  fi
}


replace_mirrorlist
add_package
clone_installer
options
