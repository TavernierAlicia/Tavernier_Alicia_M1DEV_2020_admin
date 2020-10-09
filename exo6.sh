#!/bin/bash

group=""

# Check group
checkGroup() {
  if [ $# -lt 1 ] || [ ! $1 ]
  then
    echo "[FAILED] Missing group name"
    ./"$0"
    exit 2
  fi

  test=$(cut -d: -f1 /etc/group)

  while IFS= read -r line
  do 
    if [ $1 = $line ]
    then
      return 1
    fi
  done <<< "$test"
  return 0
}

# Menu
showMenu() {
  echo "What do you want to do?"
  echo "1) Create group"
  echo "2) Remove group"
  echo "3) Exit"
  read choice
  selectMenu $choice
}

# Control menu response
selectMenu() {
  case $1 in
    "1")
      addGroup;;
    "2")
      deleteGroup;;
    "3")
      exit 0;;
    *)
      showMenu;;
  esac
}

# Prompt group name
askGroup() {
  echo "$1"
  read groupname
  group="$groupname"
  return
}

# Delete group function
deleteGroup() {
  askGroup "Witch group you want to remove?"
  checkGroup "$group"
  verif=$?
  if [ $verif -eq 0 ]
  then
    echo "[FAILED] Group doesn't exists"
    showMenu
    return
  fi
  sudo groupdel "$group"
  echo "[SUCCESS] Group $group deleted"
  showMenu
}

# Add group function
addGroup() {
  askGroup "Type the group name to create"
  checkGroup "$group"
  verif=$?
  if [ $verif -eq 1 ]
  then
    echo "[FAILED] Group already exists"
    showMenu
    return
  fi
  sudo groupadd "$group"
  echo "[SUCCESS] Group $group added"
  showMenu
}

# PROGRAM
showMenu