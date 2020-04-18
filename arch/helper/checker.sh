#!/bin/bash

# Exit codeが0以外の場合、プログラムを終了する
# param
# 1 : Exit code
# 2 : Error message
check_exit() {
  
  if [[ $# != 2 ]]; then
    echo "${0##*/}:Requires 2 argument." 1>&2
    exit 16
  fi

  if [[ $(isNumeric $1) ]]; then
    echo "${0##*/}: $1 isn't numeric." 1>&2
    exit 32
  fi

  if [[ $1 != 0 ]]; then
    echo "${0##*/}: $2." 1>&2
    exit $1
  fi
}


# Nummeric == 0
# No numericc == 1
isNumeric() {
  expr $1 + 1 > /dev/null 2>&1

  if [[ $? -lt 2 ]]; then
    return 0
  else
    return 1
  fi
}

