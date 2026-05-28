#!/bin/bash 

logfile="archive.log"
s3bucket="harsh-log-archives-2026"

log() {
	echo "$(date '+%Y-%m-%d %H:%M') $1" >> "$logfile"
}

#check if directory given by user or not
if [ -z "$1" ]
then
	echo "no directory given... exiting"
	exit 1
fi

#check if directory given by user valid or not
if [ ! -d "$1" ]
then
	echo "invalid directory... exiting"
	exit 1
fi

#sourceDirectory given by user
sourcedir="$1"

timestamp=$(date +"%Y%m%d_%H%M%S")

#create new directory for output and check whether named directory previousy exists or not
mkdir -p archives

#define archive name and its path
archivename="logs_$timestamp.tar.gz"
archivepath="archives/$archivename"

log "archive started for $sourcedir"

#compress and store in the path
tar -czf "$archivepath" "$sourcedir"

#final check
if [ $? -eq 0 ]
then 
	log "compression successful"
else
	log "compression failed"
	exit 1	
fi

if aws s3 cp "$archivepath" "s3://$s3bucket"
then 
	log "s3 upload successful"
else
	log "s3 upload failed"
	exit 1
fi

