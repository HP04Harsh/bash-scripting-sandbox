#!/bin/bash

dir="${1:-.}"
ext="${2:-txt}"
today=$(date +%Y-%m-%d)
shopt -s nullglob
files=("$dir"/*."$ext")

if [ ${#files[@]} -eq 0 ]; then
    echo "No .$ext files found in $dir"
    exit 0
fi

for file in "${files[@]}"; do
    # Extract filename without directory and extension
    filename=$(basename "$file" ."$ext")
    new_name="${dir}/${filename}_${today}.${ext}"
    
    mv "$file" "$new_name"
    echo "Renamed: $file -> $new_name"
done