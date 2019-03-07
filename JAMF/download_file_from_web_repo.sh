#!/bin/bash

#computer=$(echo $HOSTNAME | cut -f1 -d.)
computer=$2

#echo $computer

# Parameters
URL=$4
DIRECTORY=$5
FILENAME=$6
PATHNAME="$DIRECTORY/$FILENAME"

echo "Download $FILENAME from $URL to $DIRECTORY"

if [ ! -d "$DIRECTORY" ]
then
	mkdir "$DIRECTORY"
fi

cd "$DIRECTORY"

echo "Execute : curl $URL$FILENAME -o $FILENAME"

STATUS=$(curl -s -o /dev/null -w '%{http_code}' $URL$FILENAME) 

if [ $STATUS -eq 200 ]
then
	curl $URL$FILENAME -o "$FILENAME"
    echo " Téléchargement réussi"
else
	echo "Téléchargement impossible - $STATUS"
fi