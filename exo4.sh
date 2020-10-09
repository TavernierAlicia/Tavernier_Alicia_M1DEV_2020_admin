#!/bin/bash

# PROGRAM

# Check params
if [ $# -lt 1 ]
then
  echo "[FAILED] Missing group name"
  exit 2
fi

# Get groups list
test=$(cut -d: -f1 /etc/group)

# Check if group exists
while IFS= read -r line 
do 
  if [ $1 = $line ]
  then
    echo "Group $1 exists"
    exit 0
  fi
done <<< "$test"
echo "Group $1 doesn't exists"