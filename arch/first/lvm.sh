#!/bin/bash


if [[ $# != 1 ]]; then
  echo "${0##*/}: Requires 1 argument." 1>&2
  exit 16
fi

if [[ ! -b $1 ]]; then
  echo "${0##*/}: $1 isn't a device file." 1>&2
  exit 32
fi

# Enter password
echo "Set password for Device."
read -sp "Enter passphrase: " passphrase
echo
read -sp "Verify passphrase: " verify
echo

if [[ $passphrase != $verify ]]; then
  echo "${0##*/}: Sorry, passphrases do not match." 1>&2
  exit 10
fi

expect -c "
set timeout 4
spawn cryptsetup -v -c serpent-xts-plain64 -s 512 -h sha512 luksFormat $1

expect \"Are you sure? (Type uppercase yes):\"
send \"YES\n\"

expect \"Enter passphrase for\"
send \"${passphrase}\n\"

expect \"Verify passphrase:\"
send \"${verify}\n\"

expect \"\\\$\"
exit 0
"
q=$?; if [[ $q != 0 ]]; then exit $q;fi

expect -c "
set timeout 4
spawn cryptsetup luksOpen $1 decrypted

expect \"Enter passphrase for\"
send \"${passphrase}\n\"

expect \"\\\$\"
exit 0
"
q=$?; if [[ $q != 0 ]]; then exit $q;fi

pvcreate /dev/mapper/decrypted
q=$?; if [[ $q != 0 ]]; then exit $q;fi

vgcreate system /dev/mapper/decrypted
q=$?; if [[ $q != 0 ]]; then exit $q;fi

lvcreate -l 100%FREE system -n root
q=$?; if [[ $q != 0 ]]; then exit $q;fi


# For next version
# lvcreate -L 50G system -n root
# lvcreate -l 100%FREE system -n home

mkfs.xfs /dev/mapper/system-root
q=$?; if [[ $q != 0 ]]; then exit $q;fi

# mkfs.xfs /dev/mapper/system-home

exit 0
