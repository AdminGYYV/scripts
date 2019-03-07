#!/bin/bash

# Mount the requested share if it doesn't exist
# Parameters :
# n°4 : server name
# n°5 : share name
# n°6 : protocole ("afp" or "smb")

Version="0.3"

# Get JAMF scripts parameters
Current_User="$3"
MACHINENAME="$4"
SHARENAME="$5"
PROTOCOL="$6"

echo "Execute Mount volume AFP-SMB with Finder script version $Version"

sleep 3

echo "Mounting $PROTOCOL://$Current_User@$MACHINENAME/$SHARENAME"

# mount_afp "//$Current_User@$MACHINENAME/$SHARENAME" "$TARGETFOLDER"
# theuser=$(/usr/bin/who | awk '/console/{ print $1 }')
# mount volume "smb://zfssa1/home_staff/${Current_User}/"

/usr/bin/osascript > /dev/null << EOT
         tell application "Finder"
         activate
         mount volume "$PROTOCOL://$Current_User@$MACHINENAME/$SHARENAME"
         end tell
EOT

# Flushinf preference cache
killall cfprefsd
defaults write com.apple.finder ShowMountedServersOnDesktop true

# Restart Finder with "hangup signal"
killall -HUP Finder

exit 0