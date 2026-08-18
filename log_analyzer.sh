#!/usr/bin/env bash

# Exit immediately if a command exits with a non-zero status
set -euo pipefail

usage() {
    echo "Usage: $0 -f <log_file> [-n <top_results>]"
    echo "  -f : Path to the web server access log file"
    echo "  -n : Number of top results to display (default: 5)"
    exit 1
}

LOG_FILE=""
LIMIT=5

# Parse command-line flags
while getopts "f:n:" opt; do
    case "${opt}" in
        f) LOG_FILE="${OPTARG}" ;;
        n) LIMIT="${OPTARG}" ;;
        *) usage ;;
    esac
done

# Validate input file
if [[ -z "${LOG_FILE}" || ! -f "${LOG_FILE}" ]]; then
    echo "Error: Valid log file is required."
    usage
fi

echo "=================================================="
echo "           LOG ANALYSIS REPORT                    "
echo " File: ${LOG_FILE}"
echo "=================================================="
echo

# 1. Top IP addresses by request count
echo "--- Top ${LIMIT} IP Addresses ---"
awk '{print $1}' "${LOG_FILE}" | sort | uniq -c | sort -nr | head -n "${LIMIT}" | awk '{printf "%-15s %s requests\n", $2, $1}'
echo

# 2. Top requested endpoints
echo "--- Top ${LIMIT} Most Requested Endpoints ---"
awk '{print $7}' "${LOG_FILE}" | sort | uniq -c | sort -nr | head -n "${LIMIT}" | awk '{printf "%-30s %s hits\n", $2, $1}'
echo

# 3. HTTP Status Code Breakdown
echo "--- HTTP Status Code Summary ---"
awk '{print $9}' "${LOG_FILE}" | grep -E '^[0-9]{3}$' | sort | uniq -c | sort -nr | awk '{printf "Status %-5s : %s responses\n", $2, $1}'
echo "=================================================="