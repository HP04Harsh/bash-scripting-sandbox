#!/bin/bash

process_name="$1"

if [ -z "$process_name" ]; then
    echo "Usage: $0 <process_name>"
    exit 1
fi

# Search for exact process name match
pid=$(pgrep -x "$process_name")

if [ -n "$pid" ]; then
    echo "Process '$process_name' is running with PID: $pid"
else
    echo "Process '$process_name' is DOWN!"
    echo "Restarting $process_name..."
    # Example command to trigger restart:
    # systemctl restart "$process_name"
fi