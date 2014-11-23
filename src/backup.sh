#!/bin/bash

base=/home/$USER/
directory=$1
prefix="bkp"
device="$HOSTNAME"
now=$(date +%Y-%m-%d)
file=$prefix"_"$device"_"$directory"_"$now".test"

touch $file
