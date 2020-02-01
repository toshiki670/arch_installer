#!/bin/bash

source ./checker.sh




test1() {
  check_exit 0 "zero"

  check_exit 1 "error"
}
