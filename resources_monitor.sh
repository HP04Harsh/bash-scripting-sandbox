#!/usr/bin/env bash

set -euo pipefail

# Threshold limits (Percentages)
CPU_THRESHOLD=80
MEM_THRESHOLD=85
DISK_THRESHOLD=90

LOG_OUT="system_monitor.log"

log_alert() {
    local level="$1"
    local message="$2"
    local timestamp
    timestamp=$(date "+%Y-%m-%d %H:%M:%S")
    
    echo "[${timestamp}] [${level}] ${message}" | tee -a "${LOG_OUT}"
}

check_cpu() {
    # Get average CPU idle percentage from top, calculate usage
    local cpu_idle
    cpu_idle=$(top -bn1 | grep "Cpu(s)" | awk '{print $8}' | cut -d'.' -f1)
    
    # Handle variations in 'top' output formats across distros
    if [[ -z "${cpu_idle}" ]]; then
        cpu_idle=$(top -bn1 | grep "%Cpu" | awk '{print $8}' | cut -d',' -f1)
    fi
    
    local cpu_usage=$((100 - cpu_idle))
    
    if [[ "${cpu_usage}" -ge "${CPU_THRESHOLD}" ]]; then
        log_alert "WARNING" "High CPU usage detected: ${cpu_usage}% (Threshold: ${CPU_THRESHOLD}%)"
    else
        log_alert "INFO" "CPU usage normal: ${cpu_usage}%"
    fi
}

check_memory() {
    # Use 'free' to calculate used memory percentage
    local mem_usage
    mem_usage=$(free | awk '/Mem:/ {printf "%.0f", $3/$2 * 100}')
    
    if [[ "${mem_usage}" -ge "${MEM_THRESHOLD}" ]]; then
        log_alert "WARNING" "High Memory usage detected: ${mem_usage}% (Threshold: ${MEM_THRESHOLD}%)"
    else
        log_alert "INFO" "Memory usage normal: ${mem_usage}%"
    fi
}

check_disk() {
    # Check root disk partition usage
    local disk_usage
    disk_usage=$(df -h / | awk 'NR==2 {print $5}' | tr -d '%')
    
    if [[ "${disk_usage}" -ge "${DISK_THRESHOLD}" ]]; then
        log_alert "WARNING" "High Disk usage detected on /: ${disk_usage}% (Threshold: ${DISK_THRESHOLD}%)"
    else
        log_alert "INFO" "Disk usage normal on /: ${disk_usage}%"
    fi
}

main() {
    echo "Running System Health Checks..."
    check_cpu
    check_memory
    check_disk
    echo "Health check complete. Results logged to '${LOG_OUT}'."
}

main