#!/bin/bash

choose_drive() {
  lsblk -p
  read -p "Choose drive:" drive
  echo -n $drive
}
