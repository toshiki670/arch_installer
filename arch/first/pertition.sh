#!/bin/bash

# $ gdisk /dev/nvme*n*
# Boot      : 255MB: EF00
# Encrypted : FREE:  8E00

path=$1

if [[ $# != 1 ]]; then
  echo "${0##*/}: Requires 1 argument." >&1
  exit 16
fi

if [[ ! -b ${path} ]]; then
  echo "${0##*/}: $1 isn't a device file." >&1
  exit 32
fi

if ! type "gdisk" > /dev/null 2>&1; then
  echo "${0##*/}: gdisk command isn't found." >&1
  exit 64
fi


expect -c "
set timeout 4
spawn gdisk \"${path}\"

expect \"Command (? for help):\"
send \"o\n\"
expect \"Proceed? (Y/N):\"
send \"Y\n\"

expect \"Command (? for help):\"
send \"n\n\"
expect \"Partition number\"
send \"1\n\"
expect \"First sector\"
send \"\n\"
expect \"Last sector\"
send \"+255MB\n\"
expect \"Hex code or GUID\"
send \"EF00\n\"

expect \"Command (? for help):\"
send \"c\n\"
expect \"Enter name\"
send \"boot\n\"

expect \"Command (? for help):\"
send \"n\n\"
expect \"Partition number\"
send \"2\n\"
expect \"First sector\"
send \"\n\"
expect \"Last sector\"
send \"\n\"
expect \"Hex code or GUID\"
send \"8E00\n\"

expect \"Command (? for help):\"
send \"c\n\"
expect \"Partition number\"
send \"2\n\"
expect \"Enter name\"
send \"encrypted\n\"

expect \"Command (? for help):\"
send \"w\n\"
expect \"Proceed? (Y/N):\"
send \"Y\n\"

expect \"\\\$\"
exit 0
"

exit $?
