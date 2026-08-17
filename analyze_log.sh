#!/bin/bash

# Use parameter expansion to set default file if $1 is empty
LOG_FILE="${1:-access.log}"

if [ ! -f "$LOG_FILE" ]; then
    echo "Error: Log file '$LOG_FILE' not found."
    exit 1
fi

echo "--- Log Analysis for $LOG_FILE ---"

# 1. Total 404 count
count404=$(grep -c ' 404 ' "$LOG_FILE")
echo "Total 404 errors: $count404"

# 2. Unique IPs receiving 404 status codes
echo "IP addresses receiving 404s:"
awk '$9 == 404 {print $1}' "$LOG_FILE" | sort -u