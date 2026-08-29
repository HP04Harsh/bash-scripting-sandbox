#!/bin/bash

# 1. Variables and Command Substitution
USER_NAME=$(whoami)
UPTIME_INFO=$(uptime -p)
DATE_NOW=$(date "+%Y-%m-%d %H:%M:%S")

# 2. Output Header
echo "-------------------------------------"
echo "        SYSTEM DASHBOARD             "
echo "-------------------------------------"
echo "User:       $USER_NAME"
echo "Date/Time:  $DATE_NOW"
echo "Uptime:     $UPTIME_INFO"

# 3. Disk Usage Check
DISK_USAGE=$(df -h / | awk 'NR==2 {print $5}' | sed 's/%//')
echo "Disk Usage: ${DISK_USAGE}%"

# 4. Conditional Check (if-else)
if [ "$DISK_USAGE" -gt 80 ]; then
    echo "Status:     [WARNING] Storage is getting full!"
else
    echo "Status:     [OK] Storage is healthy."
fi

echo "-------------------------------------"