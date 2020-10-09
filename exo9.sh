#!/bin/bash

owner=""
group=""
other=""

# Checking if file exists
check_file() {
  param=$1
  if [ ! $param ] 
  then
    echo "[FAILED] Missing file name"
    exit 2
  elif [ ! -f "$param" ]
  then
    echo "[FAILED] File $param do not exists"
    exit 2
  fi
}

# Menu
show_menu() {
  echo "Wich permission you want to affect to $1? "
  echo "0) No rights"
  echo "1) Execute only"
  echo "2) Write only"
  echo "3) Write and execute"
  echo "4) Read only"
  echo "5) Read and execute"
  echo "6) Read and write"
  echo "7) Read, write and execute"

  read choice
  return "$choice"
}

# PROGRAM

check_file $1

# Prompt owner permissions
while [ ! $owner ]
do
  show_menu "file owner"
  choice=$?
  if [ $choice -ge 0 ] && [ $choice -le 7 ]
  then
    owner="$choice"
  else
    echo "[FAILED] $choice is not a valid entry"
  fi
done

# Prompt group permissions
while [ ! $group ]
do
  show_menu "members of file's group"
  choice=$?
  if [ $choice -ge 0 ] && [ $choice -le 7 ]
  then
    group="$choice"
  else 
    echo "[FAILED] $choice is not a valid entry"
  fi
done

# Prompt other users permissions
while [ ! $other ]
do
  show_menu "other users"
  choice=$?
  if [ $choice -ge 0 ] && [ $choice -le 7 ]
  then
    other="$choice"
  else
    echo "[FAILED] $choice is not a valid entry"
  fi
done

# Execute command
sudo chmod $owner$group$other $1
echo "[SUCCESS] $1 setted with parameters $owner$group$other"