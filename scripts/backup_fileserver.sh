#!/bin/bash
# backup_fileserver.sh - Automated rsync backup for Samba shared directory

SOURCE_DIR="/srv/shared"
BACKUP_DIR="/backups/shared_backup"
LOGFILE=~/linux-infra-automation/scripts/backup_fileserver.log
DATE=$(date '+%Y-%m-%d %H:%M:%S')

exec > >(tee -a "$LOGFILE") 2>&1

echo "=== Backup Started: $DATE ==="

# Ensure backup directory exists
sudo mkdir -p "$BACKUP_DIR"

# Run rsync (preserve perms, timestamps, delete removed files)
sudo rsync -avh --delete "$SOURCE_DIR/" "$BACKUP_DIR/"

# Check exit code of rsync
if [ $? -eq 0 ]; then
  echo "Backup successful ✅"
else
  echo "Backup failed ❌"
fi

# Verify contents
echo "=== Verifying Backup Contents ==="
sudo ls -lh "$BACKUP_DIR"

echo "=== Backup Completed at $(date '+%H:%M:%S') ==="
echo "Log saved to: $LOGFILE"
