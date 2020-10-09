#!/bin/bash

file=""

# Check file
checkFile() {
  if [ $# -lt 1 ] || [ ! $1 ]
  then
    echo "Missing file name"
    ./"$0"
    exit 2
  fi
  param=$1
  if [ -f "$param" ]
  then
    return 1
  fi
  return 0
}

# Menu
showMenu() {
  echo "What do you want to do?"
  echo "1) Create file"
  echo "2) Remove file"
  echo "3) Exit"
  read choice
  selectMenu $choice
}

# Control menu response
selectMenu() {
  case $1 in
    "1")
      addFile;;
    "2")
      deleteFile;;
    "3")
      exit 0;;
    *)
      showMenu;;
  esac
}

# Prompt file name
askFile() {
  echo "$1"
  read filename
  file="$filename"
  return
}

# Delete file function
deleteFile() {
  askFile "Witch file you want to remove?"
  checkFile "$file"
  verif=$?
  if [ $verif -eq 0 ]
  then
    echo "File doesn't exists"
    showMenu
    return
  fi
  rm "$file"
  echo "File $file deleted"
  showMenu
}

# Add file function
addFile() {
  askFile "Type the filename to create"
  checkFile "$file"
  verif=$?
  if [ $verif -eq 1 ]
  then
    echo "File already exists"
    showMenu
    return
  fi
  touch "$file"
  echo "File $file added"
  showMenu
}

# PROGRAM
showMenu