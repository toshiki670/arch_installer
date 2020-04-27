#!/bin/bash


# pacstrap /mnt base base-devel linux
# pacstrap /mnt plasma konsole dolphin filelight ark gwenview
# pacstrap /mnt zsh git vim neovim words cryfs

core_pkg=(
  "base"
  "base-devel"
  "linux"
  "linux-firmware"
  "xfsprogs"
  "pacman-contrib"
  "dhcpcd"
  "openssh"
  "wget"
)
kde_pkg=(
  "plasma"
  "konsole"
  "dolphin"
  "filelight"
  "ark"
  "gwenview"
  "cryfs"
  "gitg"
)
favorite_pkg=(
  "zsh"
  "git"
  "vim"
  "neovim"
  "words"
)

pacstrap /mnt ${core_pkg[@]} ${kde_pkg[@]} ${favorite_pkg[@]}
q=$?; if [[ $q != 0 ]]; then exit $q;fi

genfstab -U /mnt >> /mnt/etc/fstab
q=$?; if [[ $q != 0 ]]; then exit $q;fi

exit 0

