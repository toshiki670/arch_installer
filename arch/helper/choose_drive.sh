#!/bin/bash

choose_drive() {
  lsblk
  read -p "Choose drive:" drive
  echo -n $drive
}
