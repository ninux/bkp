#!/bin/bash

BASE=/home/$USER/
DIR=$1
PREFIX="bkp"
DEVICE="$HOSTNAME"
NOW=$(date +%Y-%m-%d)
EXTENSION="zip"
FILE=$PREFIX"_"$DEVICE"_"$DIR"_"$NOW"."$EXTENSION

{
	zip -r $FILE $BASE$DIR
} &> /dev/null

DIV=1024
FILESIZE=$(stat -c%s "$FILE")
let "SIZE = $FILESIZE / $DIV"

echo "created $FILE ($SIZE MB)"
