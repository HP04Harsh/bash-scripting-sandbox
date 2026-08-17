# Bash Practice Scripts

A collection of practical bash scripts for common system administration and log analysis tasks.

## Author

**Harsh Pardhi**

## Overview

This repository contains a suite of bash scripts designed to streamline common operational tasks including process monitoring, log analysis, resource management, and file operations.

## Scripts

### 1. **watchdog.sh**
Process monitoring and automatic restart utility.
- **Purpose**: Monitor if a specific process is running
- **Usage**: `./watchdog.sh <process_name>`
- **Features**: 
  - Checks if process is running using `pgrep`
  - Reports process PID if active
  - Alerts if process is down
  - Includes restart command template for automation

**Example**:
```bash
./watchdog.sh nginx
```

---

### 2. **health_monitor.sh**
System resource health checker.
- **Purpose**: Monitor disk and memory usage
- **Usage**: `./health_monitor.sh`
- **Features**:
  - Displays disk usage percentage for root partition
  - Displays memory usage percentage
  - Alerts if either exceeds 80% threshold
  - Real-time monitoring capability

**Example**:
```bash
./health_monitor.sh
```

---

### 3. **analyze_log.sh**
Web server log analysis tool.
- **Purpose**: Analyze HTTP access logs for errors and patterns
- **Usage**: `./analyze_log.sh [log_file]`
- **Features**:
  - Counts total 404 errors
  - Lists unique IP addresses generating 404 errors
  - Defaults to `access.log` if no file specified

**Example**:
```bash
./analyze_log.sh /var/log/apache2/access.log
```

---

### 4. **top_words.sh**
Word frequency analyzer.
- **Purpose**: Find the most frequently occurring words in a file
- **Usage**: `./top_words.sh <filename>`
- **Features**:
  - Converts text to lowercase for consistency
  - Removes special characters and splits into words
  - Displays top 5 most frequent words with counts
  - Useful for text analysis and content discovery

**Example**:
```bash
./top_words.sh document.txt
```

---

### 5. **ulk_rename.sh**
Bulk file renaming utility.
- **Purpose**: Batch rename files by adding today's date
- **Usage**: `./ulk_rename.sh [directory] [extension]`
- **Features**:
  - Renames all files of specified extension in a directory
  - Appends current date (YYYY-MM-DD format) to filename
  - Defaults to current directory if not specified
  - Defaults to `.txt` extension if not specified

**Example**:
```bash
# Rename all .log files in current directory
./ulk_rename.sh . log

# Rename all .bak files in /home/user/backups
./ulk_rename.sh /home/user/backups bak
```

---

## Requirements

- Bash shell (4.0+)
- Standard Unix utilities: `grep`, `awk`, `tr`, `sed`, `sort`, `uniq`, `pgrep`, `df`, `free`
- Linux/Unix-based operating system

## Installation

1. Clone the repository:
```bash
git clone https://github.com/HP04Harsh/Bash-Practice.git
cd Bash-Practice
```

2. Make scripts executable:
```bash
chmod +x *.sh
```

3. (Optional) Add to your PATH for system-wide access:
```bash
export PATH="$PATH:$(pwd)"
```

## Usage Examples

### Monitor a web server and check system health:
```bash
./watchdog.sh nginx
./health_monitor.sh
```

### Analyze logs and rename backups:
```bash
./analyze_log.sh /var/log/apache2/access.log
./ulk_rename.sh ./backups bak
```

### Find most common words in a document:
```bash
./top_words.sh report.txt
```

## Tips & Best Practices

- Always test scripts in a safe environment before using in production
- Ensure proper file permissions are set for sensitive operations
- Consider adding these scripts to a cron job for automated monitoring
- Review and customize restart commands in `watchdog.sh` for your environment
- Use `bash -x script.sh` for debugging any script

## License

MIT License - Feel free to use, modify, and distribute these scripts.

## Contributing

Contributions are welcome! Feel free to submit issues or pull requests with improvements.

---

**Last Updated**: August 2026
