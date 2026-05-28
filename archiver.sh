#!/bin/bash 

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

#compress and store in the path
tar -czf "$archivepath" "$sourcedir"

#final check
if [ $? -eq 0 ]
then 
	echo "compression successful"
else
	echo "there was an error"
	exit 1	
fi

