#!/bin/bash

# 1. Find and list all .log files larger than 10MB in /var/log
echo "Finding large log files..."
find /var/log -type f -name "*.log" -size +10M

# 2. Delete those large log files
echo "Deleting large log files..."
find /var/log -type f -name "*.log" -size +10M -delete

# 3. Show remaining disk space
df -h /