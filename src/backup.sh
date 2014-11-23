#!/bin/bash

LOGFILE="bkp.log"
BASE=/home/$USER/
DIR=$1

# check for no-argument
if [ $# -eq 0 ]
then
	echo "no argument given (see help)"
	exit 1
fi

# check for null-string
if [ -z "$1" ]
then
	echo "no argument given (see help)"
	exit 1
fi

# check for help
if [ $1 == "help" ]
then
	echo "type the directory name from $BASE you want to backup"
	exit 1
fi

# check for exact number of arguments
if [ $# -ne 1 ]
then
	echo "wrong number of arguments (see help)"
	exit 1
fi

# check if directory exists
if [ ! -d "$BASE$DIR" ]
then
	echo "given directory '$BASE$DIR' is invalid"
	exit 1
else
	PREFIX="bkp"
	DEVICE="$HOSTNAME"
	NOW=$(date +%Y-%m-%d)
	NOW_EXACT=$(date +%Y-%m-%d" "%H:%M:%S)
	EXTENSION="zip"
	FILE=$PREFIX"_"$DEVICE"_"$DIR"_"$NOW"."$EXTENSION
	
	{
		zip -r $FILE $BASE$DIR
	} &> /dev/null
	
	DIV=1024
	FILESIZE=$(stat -c%s "$FILE")
	let "SIZE = $FILESIZE / $DIV"
	MESSAGE="created $FILE ($SIZE MB)"
	echo $MESSAGE
	if [ ! -e "$LOGFILE" ]
	then
		echo "# GENERATED BACKUP LOGFILE" >> $LOGFILE
		echo "#------------------------------" >> $LOGFILE
	fi
	echo $NOW_EXACT" : "$MESSAGE >> $LOGFILE
fi
