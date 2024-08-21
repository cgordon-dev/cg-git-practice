#!/bin/bash

# Function to get IP Addresses
get_ip_addresses() {
    local private_ip=$(hostname -I | awk '{print $1}')
    local public_ip=$(curl -s ifconfig.me)
    echo "Your private IP is $private_ip, and your public IP is $public_ip."
}

# Function to get Current User
get_current_user() {
    local user=$(whoami)
    echo "You are $user."
}

# Function to get CPU Information
get_cpu_info() {
    local cpu_count=$(grep -c ^processor /proc/cpuinfo)
    echo "The system has $cpu_count CPU(s)."
}

# Function to get Memory Information
get_memory_info() {
    local mem_info=$(free -m | grep Mem)
    local total_mem=$(echo $mem_info | awk '{print $2}')
    local used_mem=$(echo $mem_info | awk '{print $3}')
    local free_mem=$(echo $mem_info | awk '{print $4}')
    echo "There is ${free_mem} MiB unused memory of total ${total_mem} MiB."
}

# Function to get Top 5 Memory Processes
get_top_memory_processes() {
    echo "Top 5 Memory Processes:"
    echo "pmem   pid       cmd"
    ps -eo pmem,pid,cmd --sort=-pmem | head -n 6
}

# Function to get Top 5 CPU Processes
get_top_cpu_processes() {
    echo "Top 5 CPU Processes:"
    echo "pcpu   pid       cmd"
    ps -eo pcpu,pid,cmd --sort=-pcpu | head -n 6
}

# Function to test Network Connectivity
test_network_connectivity() {
    read -p "Enter a website or IP address to test connectivity: " address
    # Remove 'http://' or 'https://' if present
    address=$(echo $address | sed -e 's#https://##' -e 's#http://##')
    
    ping -c 4 $address &> /tmp/ping_result
    if [ $? -eq 0 ]; then
        local avg_time=$(grep "avg" /tmp/ping_result | awk -F '/' '{print $5}')
        echo "It took ${avg_time}ms to connect to $address and there was 0% data packet loss."
    else
        echo "Failed to connect to $address."
    fi
}


# Main loop
while true; do
    echo "
Please choose an option:
1. IP Addresses
2. Current User
3. CPU Information
4. Memory Information
5. Top 5 Memory Processes
6. Top 5 CPU Processes
7. Network Connectivity
8. Exit
    "
    read -p "Enter your choice: " choice

    case $choice in
        1) get_ip_addresses ;;
        2) get_current_user ;;
        3) get_cpu_info ;;
        4) get_memory_info ;;
        5) get_top_memory_processes ;;
        6) get_top_cpu_processes ;;
        7) test_network_connectivity ;;
        8) echo "Exiting..."; exit 0 ;;
        *) echo "Invalid choice. Please try again." ;;
    esac
done
