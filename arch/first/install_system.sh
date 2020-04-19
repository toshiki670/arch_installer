#!/bin/bash


# pacstrap /mnt base base-devel linux
# pacstrap /mnt plasma konsole dolphin filelight ark gwenview
# pacstrap /mnt zsh git vim neovim words cryfs

core_pkg=(
  "base"
  "base-devel"
  "linux"
)
kde_pkg=(
  "plasma"
  "konsole"
  "dolphin"
  "filelight"
  "ark"
  "gwenview"
  "cryfs"
)
favorite_pkg=(
  "zsh"
  "git"
  "vim"
  "neovim"
  "words"
)

pacstrap /mnt ${core_pkg[@]} ${kde_pkg[@]} ${favorite_pkg[@]}
result=$?; if [[ $result != 0 ]]; then return $result;fi

genfstab -U /mnt >> /mnt/etc/fstab
result=$?; if [[ $result != 0 ]]; then return $result;fi

return 0

