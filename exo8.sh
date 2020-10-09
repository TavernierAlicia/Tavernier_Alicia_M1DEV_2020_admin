#!/bin/bash
user=""
group=""

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

# Check if group exists
check_group() {
  test=$(cut -d: -f1 /etc/group)
  while IFS= read -r line 
  do 
    if [ $1 = $line ]
    then
      return 1
    fi
  done <<< "$test"
  echo "[FAILED] Group $1 doesn't exists"
  return 0
}

# Check if user exists
check_user() {
  test=$(cut -d: -f1 /etc/passwd)

  while IFS= read -r line 
  do 
    if [ $1 = $line ]
    then
      return 1
    fi
  done <<< "$test"
  echo "[FAILED] User $1 doesn't exists"
  return 0
}

# PROGRAM

check_file $1

# Prompt username
while [ ! $user ]
do
  echo "Type the new user"
  read username
  check_user $username
  verif_user=$?
  if [ $verif_user -eq 1 ]
  then
    user="$username"
  fi
done

# Prompt groupname
while [ ! $group ]
do
  echo "Type the new group"
  read groupname
  check_group $groupname
  verif_group=$?
  if [ $verif_group -eq 1 ]
  then
    group="$groupname"
  fi
done

# Execute command
sudo chown $user:$group $1
echo "[SUCCESS] $1 setted with parameters $user:$group"