#!/bin/bash

# Configuration Variables
SOURCE_DIR="$HOME/Documents"
BACKUP_DIR="$HOME/Backup"
DATE=$(date +%Y-%m-%d_%H-%M-%S)
BACKUP_FILE="$BACKUP_DIR/backup_$DATE.tar.gz"

# 1. Check if the source directory exists
if [ ! -d "$SOURCE_DIR" ]; then
    echo "❌ Error: Source directory $SOURCE_DIR does not exist."
    exit 1
fi

# 2. Create the backup destination folder if missing
if [ ! -d "$BACKUP_DIR" ]; then
    echo "Creating backup directory..."
    mkdir -p "$BACKUP_DIR"
fi

# 3. Create the compressed backup (tar archive)
echo "Starting backup of $SOURCE_DIR..."
tar -czf "$BACKUP_FILE" "$SOURCE_DIR" 2>/dev/null

# 4. Check if the backup command succeeded
if [ $? -eq 0 ]; then
    echo "✅ Backup successful! Saved to $BACKUP_FILE"
else
    echo "❌ Backup failed."
    exit 1
fi

# 5. Medium Level Concept: Keep only the 5 most recent backups (cleanup old ones)
echo "Cleaning up old backups..."
ls -t "$BACKUP_DIR"/backup_*.tar.gz | tail -n +6 | xargs rm -f

echo "Done!"
