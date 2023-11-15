# security-camera-maintenance

Automatically delete old recordings from security cameras.

## Usage

| Environment Variable | Description                                | Default Value |
|----------------------|--------------------------------------------|---------------|
| mp4DaysToRetain      | The number of days of .mp4 files to retain | `30`          |
| jpgDaysToRetain      | The number of days of .jpg files to retain | `100`         |
| directory            | The directory to look in for files         | `.`           |
| delete               | Safety flag, allowing for a dry run        | `false`       | 
| DELAY                | How often to run the script                | `1d`          |  
