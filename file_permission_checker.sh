#!/bin/bash


#This script will check if a file is readable, writeable, and executable.
#Choosing to use conditional statements to accomplish this.



# Check if a file was provided as an argument
if [ -z "$1" ]; then
  echo "Usage: $0 filename"
  exit 1
fi

File=$1

# Check if the file exists
if [ ! -e "$File" ]; then
  echo "File does not exist."
  exit 1
fi

# Check if the file is readable
if [ -r "$File" ]; then
  echo "$File is readable."
else
  echo "$File is not readable."
fi

# Check if the file is writable
if [ -w "$FILE" ]; then
  echo "$File is writable."
else
  echo "$File is not writable."
fi

# Check if the file is executable
if [ -x "$FILE" ]; then
  echo "$File is executable."
else
  echo "$File is not executable."
fi

exit 0
