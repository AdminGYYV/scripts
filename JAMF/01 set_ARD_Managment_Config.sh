#!/bin/bash

if test "$4" = "YES"
then
    sudo defaults write /Library/Preferences/com.apple.RemoteManagement DirectoryGroupLoginsEnabled -bool true
	echo "Execute sudo defaults write /Library/Preferences/com.apple.RemoteManagement DirectoryGroupLoginsEnabled -bool true"
else
    sudo defaults write /Library/Preferences/com.apple.RemoteManagement DirectoryGroupLoginsEnabled -bool false
	echo "Execute sudo defaults write /Library/Preferences/com.apple.RemoteManagement DirectoryGroupLoginsEnabled -bool false"	
fi

sudo defaults write /Library/Preferences/com.apple.RemoteManagement VNCLegacyConnectionsEnabled -bool false

sudo defaults write /Library/Preferences/com.apple.RemoteManagement LoadRemoteManagementMenuExtra -bool true

sudo defaults write /Library/Preferences/com.apple.RemoteManagement ScreenSharingReqPermEnabled -bool false

sudo defaults write /Library/Preferences/com.apple.RemoteManagement AllowSRPForNetworkNodes -bool false

sudo defaults write /Library/Preferences/com.apple.RemoteManagement ARD_AllLocalUsersPrivs 1073742079

sudo defaults write /Library/Preferences/com.apple.RemoteManagement ARD_AllLocalUsers -bool false

sudo defaults write /Library/Preferences/com.apple.RemoteManagement DisableKerberos -bool false



sudo defaults write /Library/Preferences/com.apple.RemoteDesktop ard_admin "(maitres, remplacants, stagiairesa, stagiairesb)"

sudo defaults write /Library/Preferences/com.apple.RemoteDesktop ard_manage "()"

sudo defaults write /Library/Preferences/com.apple.RemoteDesktop ard_reports "()"

sudo defaults write /Library/Preferences/com.apple.RemoteDesktop ard_interact "()"

sudo defaults write /Library/Preferences/com.apple.RemoteDesktop DOCAllowRemoteConnections -bool false