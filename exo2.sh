#!/bin/bash


# Checking if file(s) exists
check_files() {
  param=$1
  if [ ! -f "$param" ]
  then
    echo "[FAILED] File $param do not exists"
    exit 2
  fi
}


# PROGRAM
if [ $# -lt 2 ]
then
  echo "[FAILED] Missing parameters"
  exit 2
fi

check_files $1

# Switch case for different actions
case $2 in 
  "copy")
    cp "$1" /tmp/script
    echo "[SUCCESS] File copied in /tmp/script" ;;

  "delete")
    rm "$1"
    echo "[SUCCESS] File deleted" ;;

  "read")
    cat "$1";;

  *)
    echo "[FAILED] Command not recognized";;

esac