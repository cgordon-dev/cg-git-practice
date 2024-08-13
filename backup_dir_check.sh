#!/bin/bash

# Define the directory name
directory="backup"

# Check if the directory exists
if [ ! -d "$directory" ]; then
  # If the directory does not exist, create it
  mkdir "$directory"
  echo "Directory '$directory' is created."
else
  echo "Directory '$directory' already exists."
fi
