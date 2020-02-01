#!/bin/bash


pacstrap /mnt base base-devel linux 
pacstrap /mnt plasma konsole dolphin filelight ark gwenview
pacstrap /mnt zsh git vim neovim words cryfs

genfstab -U /mnt >> /mnt/etc/fstab

exit 0
