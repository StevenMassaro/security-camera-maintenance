#!/bin/sh

# Configuration
THRESHOLD=${THRESHOLD:-80}
directory=${directory:-.}
delete=${delete:-false}

# Function to get current disk usage percentage
get_disk_usage() {
  df -h "$directory" | grep -Eo '[0-9]+%' | tr -d '%'
}

# Function to delete the oldest files
delete_oldest_files() {
  while [ "$(get_disk_usage)" -ge "$THRESHOLD" ]; do
    OLDEST_FILE=$(find "$directory" -type f -printf '%T@ %p\n' | sort -n | head -n 1 | cut -d' ' -f2-)
    if [ -z "$OLDEST_FILE" ]; then
      echo "No more files to delete."
      break
    fi
      if [ "$delete" = "true" ]
      then
        echo "Deleting $OLDEST_FILE to free up space."
        rm -f "$OLDEST_FILE"
      else
        echo "Would delete $OLDEST_FILE to free up space."
      fi
  done
  if [ "$delete" = "true" ]
  then
    echo Deleting empty directories
    find "$directory" -type d -empty -print -delete
  else
    echo Dry run, not performing deletions
    find "$directory" -type d -empty
  fi
}

# Get current disk usage
CURRENT_USAGE=$(get_disk_usage)

# Check if disk usage exceeds the threshold
if [ "$CURRENT_USAGE" -ge "$THRESHOLD" ]; then
  echo "Disk usage is at ${CURRENT_USAGE}%. Threshold is ${THRESHOLD}%."
  echo "Starting cleanup process."
  delete_oldest_files
  echo "Cleanup complete. Current disk usage is $(get_disk_usage)%."
else
  echo "Disk usage is at ${CURRENT_USAGE}%. No cleanup needed."
fi
