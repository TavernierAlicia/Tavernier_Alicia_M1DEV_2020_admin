#!/bin/bash

# Checking if file(s) given
check_params() {
  nb_params=$1
  if [ $nb_params -eq 0 ] 
  then
    echo "[FAILED] No files given"
    exit 2
  else
    echo "$nb_params files given"
  fi
}

# Checking if file(s) exists
check_files() {
  for param in "$@"
  do
    if [ -f "$param" ]
    then
      echo "File $param exists"
    else
      echo "File $param do not exists"
    fi
  done
}

# PROGRAMME
check_params $#
check_files $@