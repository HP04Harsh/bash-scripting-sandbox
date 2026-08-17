#!/bin/bash

# Function to check disk usage
check_disk() {
    # Extract root partition usage percentage, dropping the % symbol
    usage=$(df / | awk 'NR==2 {print $5}' | tr -d '%')
    echo "Disk Usage: ${usage}%"
    return "$usage"
}

# Function to check memory usage
check_mem() {
    # Calculate percentage using free command output
    usage=$(free | awk '/Mem:/ {printf "%.0f", $3/$2 * 100}')
    echo "Memory Usage: ${usage}%"
    return "$usage"
}

# Run checks
check_disk
disk_val=$?

check_mem
mem_val=$?

# Alert if either exceeds 80%
if [ "$disk_val" -gt 80 ] || [ "$mem_val" -gt 80 ]; then
    echo -e "\033[1;31m[ALERT] High resource usage detected!\033[0m"
fi