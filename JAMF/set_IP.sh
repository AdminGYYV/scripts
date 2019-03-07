#!/bin/bash

#computer=$(echo $HOSTNAME | cut -f1 -d.)
computer=$2

#echo $computer

DIRECTORY="/.gyyv"
FILENAME="IP.csv"
PATHNAME="$DIRECTORY/$FILENAME"

#echo $PATHNAME

if [ ! -d "$DIRECTORY" ]
then
	mkdir "$DIRECTORY"
fi

cd "$DIRECTORY"

curl http://media.gyyv.vd.ch:81/$FILENAME -o "$FILENAME"

export IFS=","
cat "$PATHNAME" | while read name ip 
do 
  if [ "$computer" == "$name" ] 
  then
    echo "Setting manual IP address... " "$ip"
    networksetup -setmanual "Ethernet" $ip 255.255.0.0 172.16.0.1
    networksetup -setmanual "Wi-Fi" $ip 255.255.0.0 172.16.0.1
  fi 
done 