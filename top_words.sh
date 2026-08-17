#!/bin/bash

file="$1"

if [ -z "$file" ] || [ ! -f "$file" ]; then
    echo "Usage: $0 <filename>"
    exit 1
fi

# Pipeline process: lowercase -> split non-alphanumeric to lines -> sort -> count -> rank
cat "$file" | \
    tr '[:upper:]' '[:lower:]' | \
    tr -cs '[:alnum:]' '\n' | \
    sort | \
    uniq -c | \
    sort -nr | \
    head -n 5