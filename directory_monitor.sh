#!/bin/bash

#Asks the user for a directory they'd like to monitor and takes the name as an argument.

#Calculates the total size of the directory. Hint: du command

#Displays a message saying "Warning: Directory exceeds 100MB" if the size is greater than 100MB.


# Check if the directory is provided as an argument
if [ -z "$1" ]; then
    # If no argument is provided, prompt the user for a directory
    read -p "Please enter the directory you'd like to monitor: " Directory
else
    # If an argument is provided, use it as the directory
    Directory=$1
fi



# Check if the directory exists
if [ ! -d "$Directory" ]; then
    echo "$Directory does not exist."
    exit 1
fi


# Calculate the total size of the directory

#returns size in kilobytes, and then use the cut command so that  we get only the size (1st column)
filesize=$(du -sk "$Directory" | cut -f1)


# Convert 100MB to kilobytes for comparison
max_size_kb=$((100 * 1024))


# Condition if directory is greater than 100MB
if [ "$filesize" -gt "$max_size_kb" ]; then
    echo "Warning: $Directory exceeds 100MB"
else
    echo "The size of $Directory is $(du -sh "$Directory" | cut -f1)."
fi

#Success!
exit 0
