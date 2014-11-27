#!/bin/bash

#check if number of arguments are correct

if [ "$#" -ne 2 ]; then
    if [[ -z "$1"  ]]; then
        echo "No Input File Specified (e.g.: input/filename.txt)";
    fi
    if [[ -z "$2"  ]]; then
        echo "No Output File Specified (e.g.: output/filename.csv)";
    fi

    exit 0;
fi

old_IFS=$IFS      # save the field separator           
IFS=$'\n'     # new field separator, the end of line           
FILENAME=$1
sek=$(cat $FILENAME | wc -l)
for line in $(cat $FILENAME) 
do          
	MD5=$(md5 -qs $line);
	echo "$line;$MD5" >> $2
	echo -ne "Records Remaining $sek ... \r"
	sek=$[$sek-1]
done   
IFS=$old_IFS     # restore default field separator 
