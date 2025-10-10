#!/bin/bash


# === Fixed Paths ===
src="/home/ubuntu/scripts"
dest="/home/ubuntu/backups"

# === Step 1: Check if source exists ===
if [ ! -d "$src" ]; then
  echo  "Error: Source directory '$src' does not exist."
  exit 1
fi

# === Step 2: Create destination if it doesn't exist ===
mkdir -p "$dest"

# === Step 3: Create a timestamp ===
timestamp=$(date '+%Y-%m-%d_%H-%M-%S')

# === Step 4: Define backup filename ===
backup_file="$dest/backup_$timestamp.zip"

# === Step 5: Create a ZIP backup ===
zip -r "$backup_file" "$src" >/dev/null 2>&1

if [ $? -eq 0 ]; then
  echo "✅ Backup created successfully: $backup_file"
else
  echo "❌ Backup failed!"
  exit 1
fi

# === Step 6: Backup rotation (keep only last 3 backups) ===
cd "$dest" || exit
backups=( $(ls -t backup_*.zip 2>/dev/null) )

if [ ${#backups[@]} -gt 3 ]; then
  delete_count=$(( ${#backups[@]} - 3 ))
  echo "🧹 Removing $delete_count old backup(s)..."
  for old_backup in "${backups[@]:3}"; do
    rm -f "$old_backup"
    echo "Removed: $old_backup"
  done
else
  echo "No old backups to remove."
fi

echo "🎯 Backup rotation complete."






