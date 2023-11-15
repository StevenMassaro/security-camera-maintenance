mp4DaysToRetain=${mp4DaysToRetain:-30}
jpgDaysToRetain=${jpgDaysToRetain:-100}
directory=${directory:-.}
delete=${delete:-false}

if [ "$delete" = "true" ]
then
  echo Deleting! Sleeping for 10 seconds as a safety measure.
  sleep 10s
  echo Deleting all .idx files
  find "$directory" -type f -name "*.idx" -delete
else
  echo Dry run, not performing deletions
  find "$directory" -type f -name "*.idx"
fi

# Delete all old files (this is purposefully not using simple find -mtime logic, because that is very slow with rclone mounted drive)
delete() {
  local extension=$1
  local daysToRetain=$2

  daysToRetainStart=$((daysToRetain + 30))
  echo Deleting ."$extension" files whose age are between "$daysToRetainStart" and "$daysToRetain" days

  for i in $(seq "$daysToRetain" "$daysToRetainStart");
  do
    date=$(date --date="$i"' days ago' +"%Y-%m-%d")
    echo Processing day "$i" - "$date"
    if [ "$delete" = "true" ]
    then
      find "$directory" -type f -path "*${date}*/*.${extension}" -delete
    else
      find "$directory" -type f -path "*${date}*/*.${extension}"
    fi
  done
}

delete "mp4" "$mp4DaysToRetain"
delete "jpg" "$jpgDaysToRetain"
