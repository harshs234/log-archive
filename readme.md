# Log Archive Tool

A Bash script that archives log directories by compressing them into timestamped `.tar.gz` files.

## Features

- Accepts a directory path as input
- Validates user input
- Creates timestamped archives
- Automatically creates archive directory
- Compresses logs using tar and gzip

## Usage

```bash
./archiver.sh /var/log
