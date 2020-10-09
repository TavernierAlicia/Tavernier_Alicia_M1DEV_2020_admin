#!/bin/bash

# PROGRAM

# Check params
if [ $# -lt 1 ]
then
  echo "[FAILED] Missing Username"
  exit 2
fi

# Get users list
test=$(cut -d: -f1 /etc/passwd)

# Check if user exists
while IFS= read -r line 
do 
  if [ $1 = $line ]
  then
    echo "User $1 exists"
    exit 0
  fi
done <<< "$test"
echo "User $1 doesn't exists"