#!/bin/expect

# $ gdisk /dev/nvme*n*
# Boot      : 255MB: EF00
# Encrypted : FREE:  8E00


set timeout 4

spawn gdisk [lindex $argv 0]

# Initialize GPT pertition
expect {
  -glob "Command (? for help):" {
    send "o\n"
    exp_continue
  }
  -glob "Proceed? (Y/N):" {
    send "Y\n"
  }
}

# Setup boot partition
expect {
  -glob "Command (? for help):" {
    send "n\n"
    exp_continue
  }
  -glob "Partition number" {
    send "1\n"
    exp_continue
  }
  -glob "First sector" {
    send "\n"
    exp_continue
  }
  -glob "Last sector" {
    send "+255MB\n"
    exp_continue
  }
  -glob "Hex code or GUID" {
    send "EF00\n"
  }
}

# rename boot partition
expect {
  -glob "Command (? for help):" {
    send "c\n"
    exp_continue
  }
  -glob "Enter name" {
    send "boot\n"
  }
}

# Setup main partition
expect {
  -glob "Command (? for help):" {
    send "n\n"
    exp_continue
  }
  -glob "Partition number" {
    send "2\n"
    exp_continue
  }
  -glob "First sector" {
    send "\n"
    exp_continue
  }
  -glob "Last sector" {
    send "\n"
    exp_continue
  }
  -glob "Hex code or GUID" {
    send "8E00\n"
  }
}

# rename main
expect {
  -glob "Command (? for help):" {
    send "c\n"
    exp_continue
  }
  -glob "Partition number" {
    send "2\n"
  }
  -glob "Enter name" {
    send "encrypted\n"
  }
}

# Write
expect {
  -glob "Command (? for help):" {
    send "w\n"
    exp_continue
  }
  -glob "Proceed? (Y/N):" {
    send "Y\n"
  }
}

expect {
  -glob "\\\$" {
    exit 0
  }
}
