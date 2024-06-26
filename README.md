# security-camera-maintenance

Automatically delete old recordings from security cameras.

This script operates in two different ways:
- `age` based deletion of files
- `free-space` based deletion of files

## Usage

Set an environment variable `type` to match one of the type types above.

### Common Properties

| Environment Variable | Description                                | Default Value |
|----------------------|--------------------------------------------|---------------|
| directory            | The directory to look in for files         | `.`           |
| delete               | Safety flag, allowing for a dry run        | `false`       | 
| DELAY                | How often to run the script                | `1d`          |  

### Age Based Deletion

| Environment Variable | Description                                | Default Value |
|----------------------|--------------------------------------------|---------------|
| mp4DaysToRetain      | The number of days of .mp4 files to retain | `30`          |
| jpgDaysToRetain      | The number of days of .jpg files to retain | `100`         |

### Free Space Based Deletion

| Environment Variable | Description                                    | Default Value |
|----------------------|------------------------------------------------|---------------|
| THRESHOLD            | Maximum allowed percent of consumed disk space | `80`          |  
