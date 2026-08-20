#!/usr/bin/env bash

# 1. Configuration
URL="https://news.ycombinator.com/"
OUTPUT_FILE="scraped_titles.csv"

# 2. Fetch HTML, parse titles using regex, and save to CSV
curl -sL "${URL}" | \
grep -oP 'class="titleline"><a href="\K[^"]*">[^\<]*' | \
sed 's/">/", "/g' | \
awk '{print "\"" $0 "\""}' > "${OUTPUT_FILE}"

echo "Scraped data saved to ${OUTPUT_FILE}"