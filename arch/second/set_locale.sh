#!/bin/bash


vim /etc/locale.gen
q=$?; if [[ $q != 0 ]]; then exit $q;fi

locale-gen
exit $?
