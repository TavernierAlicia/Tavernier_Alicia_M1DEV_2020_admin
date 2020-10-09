#!/bin/bash

user=""

# Check user
checkUser() {
  if [ $# -lt 1 ] || [ ! $1 ]
  then
    echo "[FAILED] Missing Username"
    ./"$0"
    exit 2
  fi

  test=$(cut -d: -f1 /etc/passwd)

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
  echo "1) Create user"
  echo "2) Remove user"
  echo "3) Exit"
  read choice
  selectMenu $choice
}

# Control menu response
selectMenu() {
  case $1 in
    "1")
      addUser;;
    "2")
      deleteUser;;
    "3")
      exit 0;;
    *)
      showMenu;;
  esac
}

# Prompt username
askUser() {
  echo "$1"
  read username
  user="$username"
  return
}

# Delete user function
deleteUser() {
  askUser "Witch username you want to remove?"
  checkUser "$user"
  verif=$?
  if [ $verif -eq 0 ]
  then
    echo "[FAILED] User doesn't exists"
    showMenu
    return
  fi
  sudo userdel "$user"
  echo "[SUCCESS] User $user deleted"
  showMenu
}


# Add user function
addUser() {
  askUser "Type the username to create"
  checkUser "$user"
  verif=$?
  if [ $verif -eq 1 ]
  then
    echo "[FAILED] User already exists"
    showMenu
    return
  fi
  sudo useradd "$user"
  echo "[SUCCESS] User $user added"
  showMenu
}

# PROGRAM
showMenu