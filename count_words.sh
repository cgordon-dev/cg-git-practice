#!/bin/bash

#Script that counts the occurences of a specific word
#chosen by the user in a given text file


# Check if a filename is provided
if [ $# -ne 1 ]; then
  echo "Usage: $0 filename"
  exit 1
fi

# Assign the filename to a variable called filename
filename="$1"

# Check if the file exists
if [ ! -f "$filename" ]; then
  echo "Error: The file '$filename' does not exist. Please provide a valid file."
  exit 1
fi

# Prompt the user to enter the word to count
read -p "Enter the word you want to count: " word

# Count the occurrences of the word in the file (case-insensitive)
count=$(grep -woi "$word" "$filename" | wc -l)

# Display the results
echo "Counting occurrences of '$word' in $filename..."
echo "The word '$word' occurs $count times in $filename."
exit 0