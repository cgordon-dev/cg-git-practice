#!/bin/bash

# Function to display usage
usage() {
    echo "Usage: $0 <logfile>"
    exit 1
}

# Check if the logfile is provided
if [ -z "$1" ]; then
    echo "Error: No log file provided."
    usage
fi

# Check if the logfile exists
if [ ! -f "$1" ]; then
    echo "Error: Log file does not exist."
    usage
fi

logfile="$1"

# Process the logfile line by line
while IFS= read -r line; do
    # Extract IPs associated with "404" errors
    if echo "$line" | grep -q "404"; then
        ip=$(echo "$line" | awk '{print $1}' | awk -F',"' '{print $2}')
        echo "$ip"
    fi
done < "$logfile" | sort | uniq -c

# Check if the previous command was successful
if [ $? -ne 0 ]; then
    echo "Error: Failed to process the log file."
    exit 1
fi

exit 0
