#!/bin/bash

## Computer settings
##
## Parameters :
##	$4 : YES/NO (default NO) Wifi enable or disable
##	$5 : YES/NO (default NO) managable with ARD for teacher (for student's computers in classroom)
##
## v1.2 - cedrdelm - 03.12.2018 - correctifs pour les accès ssh et ARD
##								- suppression de la config WIFI et ARD du script
##
## v1.1 - cedrdelm - 09.10.2018 - merge configuration profiles
##									00 Apple Software Updates configuration
##									01 Bluetooth off
##									com.apple.systemuiserver
##									system preferences - Disable MultipleSession + bluetooth
##
## v1.0 - cedrdelm - 08.10.2018 - merge many different scripts
##									set_GlobalPreferences_computerLevel_HighSierra.sh
##									enableARD
##									enableSSH
##									MS Office 2016 - First Dialog disable
##									Remove Adobe Launch Agents
##									Remove Microsoft Office 2016 Updater App
##									Set Default Language and local (High Sierra)
##									Set Keyboard and local default settings
##									Set TimeZone & NTP server
##									set_HiToolbox_computerLevel_HighSierra
##									set_GlobalPreferences_userLevel_HighSierra (pour les utilisateur locaux)
##									set_HiToolbox_computerLevel_HighSierra (pour les utilisateur locaux)
##									set_secondary_DNS
##									setARDManagmentConfig
##									Wifi-Disable/Enable
##
## 

Version="1.2.1"

# Set admin local name
localAdminUsername="chocolat"

# Set your timezone and ntp server here
TimeZone="Europe/Zurich"
ntpServer="timesrv.vd.ch"

# Wifi enable or not YES/NO
#	if test "$4" = "YES"
#	then
#		WIFI="YES"
#	else
#		WIFI="NO"	
#	fi

# Computer managed with ARD for teacher YES/NO
#	if test "$5" = "YES"
#	then
#		ARD_MANAGED="YES"
#	else
#		ARD_MANAGED="NO"	
#	fi


echo "Computer setting v."$Version

#### Network setup ####

	networksetup -setdnsservers Ethernet 172.16.0.11 172.16.0.22
	networksetup -setdnsservers Wi-Fi 172.16.0.11 172.16.0.22
	
	networksetup -setsearchdomains Ethernet gyyv.vd.ch
	networksetup -setsearchdomains Wi-Fi gyyv.vd.ch

#	if test "WIFI" = "YES"
#	then
#		networksetup -setairportpower Wi-Fi On
#	networksetup -setnetworkserviceenabled Wi-Fi On
#	else
#		networksetup -setairportpower Wi-Fi Off
#		networksetup -setnetworkserviceenabled Wi-Fi Off
#	fi



#### TimeZone & Time sever ####

	# set the time zone
	/usr/sbin/systemsetup -setusingnetworktime off
	/usr/sbin/systemsetup -settimezone $TimeZone
	/usr/sbin/systemsetup -setusingnetworktime on
	/usr/sbin/systemsetup -setnetworktimeserver $ntpServer
	
	# update the time
	/usr/sbin/ntpdate -bs $ntpServer

#### .GlobalPreferences ####
    
    # Localization setting
    sudo defaults write /Library/Preferences/.GlobalPreferences AppleLanguages "(fr-CH,fr,en,de,it,es,it,pt,nl)"
    
    sudo defaults write /Library/Preferences/.GlobalPreferences AppleLocale "fr_CH"
    
    sudo defaults write /Library/Preferences/.GlobalPreferences AppleTextDirection 0
    
    sudo defaults write /Library/Preferences/.GlobalPreferences Country "CH"
    
    sudo defaults write /Library/Preferences/.GlobalPreferences MultipleSessionEnabled -bool false
    
    sudo defaults write /Library/Preferences/.GlobalPreferences "com.apple.AppleModemSettingTool.LastCountryCode" "CH"
    
    sudo defaults write /Library/Preferences/.GlobalPreferences "com.apple.TimeZonePref.Last_Selected_City" "(
        46.77869,
        6.6414,
        0,
        Europe/Zurich,
        CH,
        Yverdon,
        Switzerland,
        Yverdon,
        Switzerland,
        )"
    
    # Keyboard setting
    sudo defaults write /Library/Preferences/.GlobalPreferences AppleKeyboardUIMode 3
    
    sudo defaults write /Library/Preferences/.GlobalPreferences AppleMeasurementUnits "Centimeter"
    
    sudo defaults write /Library/Preferences/.GlobalPreferences AppleMetricUnits -bool true
    
    # Decimal character
    sudo defaults write /Library/Preferences/.GlobalPreferences AppleICUNumberSymbols -dict "0" "."
    
    sudo defaults write /Library/Preferences/.GlobalPreferences "com.apple.ColorSync.Devices" "/Library/Caches/ColorSync/com.apple.colorsync.devices"
	
	# Disable Resume system-wide
    sudo defaults write /Library/Preferences/.GlobalPreferences NSQuitAlwaysKeepsWindows -bool false
    
    # Save to disk (not to iCloud) by default
    sudo defaults write /Library/Preferences/.GlobalPreferences NSDocumentSaveNewDocumentsToCloud -bool false
    
    # Expanding the save panel by default
    sudo defaults write /Library/Preferences/.GlobalPreferences NSNavPanelExpandedStateForSaveMode -bool true
    
    # Expand print panel by default
    sudo defaults write /Library/Preferences/.GlobalPreferences PMPrintingExpandedStateForPrint -bool true

#### com.apple.Bluetooth ####

    sudo defaults write com.apple.Bluetooth BluetoothAutoSeekKeyboard -bool false
    sudo defaults write com.apple.Bluetooth BluetoothAutoSeekPointingDevice -bool false

#### com.apple.desktopservices ####

    # Avoiding creating stupid .DS_Store files on network volumes
    sudo defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

#### com.apple.HIToolbox ####

	# set the "current" keyboard layout
	sudo defaults write /Library/Preferences/com.apple.HIToolbox AppleCurrentKeyboardLayoutInputSourceID com.apple.keylayout.SwissFrench
	
	# set the default keyboard
	sudo defaults write /Library/Preferences/com.apple.HIToolbox AppleDefaultAsciiInputSource\
    -dict InputSourceKind "Keyboard Layout" "KeyboardLayout ID" -int 18 "KeyboardLayout Name" "Swiss French"
    
    # set the "selected" Input Source
    sudo defaults write /Library/Preferences/com.apple.HIToolbox AppleSelectedInputSources -array\
    '<dict><key>InputSourceKind</key><string>Keyboard Layout</string><key>KeyboardLayout ID</key><integer>18</integer><key>KeyboardLayout Name</key><string>Swiss French</string></dict>'

	# set the "enabled" Input Source
    sudo defaults delete "/Library/Preferences/"com.apple.HIToolbox AppleEnabledInputSources
    sudo defaults write "/Library/Preferences/"com.apple.HIToolbox AppleEnabledInputSources -array-add\
    '<dict><key>InputSourceKind</key><string>Keyboard Layout</string><key>KeyboardLayout ID</key><integer>18</integer><key>KeyboardLayout Name</key><string>Swiss French</string></dict>'

	# enable on-screen keyboard and character viewers
    sudo defaults write /Library/Preferences/com.apple.HIToolbox AppleEnabledInputSources -array-add\
    '<dict><key>Bundle ID</key><string>com.apple.CharacterPaletteIM</string><key>InputSourceKind</key><string>Non Keyboard Input Method</string></dict>'
    sudo defaults write /Library/Preferences/com.apple.HIToolbox AppleEnabledInputSources -array-add\
    '<dict><key>Bundle ID</key><string>com.apple.KeyboardViewer</string><key>InputSourceKind</key><string>Non Keyboard Input Method</string></dict>'
    sudo defaults write /Library/Preferences/com.apple.HIToolbox AppleEnabledInputSources -array-add\
	'<dict><key>Bundle ID</key><string>com.apple.PressAndHold</string><key>InputSourceKind</key><string>Non Keyboard Input Method</string></dict>'


#### com.apple.LaunchServices ####

    # Disable the “Are you sure you want to open this application?” dialog
    sudo defaults write com.apple.LaunchServices LSQuarantine -bool false


#### com.apple.loginwindow ####

 	# Reveal IP address, hostname, OS version, etc. when clicking the clock
    # in the login window
    sudo defaults write /Library/Preferences/com.apple.loginwindow AdminHostInfo HostName

#### com.apple.MCXBluetooth ####
	
	sudo defaults write com.apple.MCXBluetooth RemoteWakeEnabled -bool false
	sudo defaults write com.apple.MCXBluetooth DisableBluetooth -bool true

#### com.apple.NetworkAuthorization ####

    # Don't ask for password when mounting a network share
	sudo defaults write /Library/Preferences/com.apple.NetworkAuthorization AllowUnknownServers -bool YES   

#### com.apple.screensaver ####

    # Requiring password immediately after sleep or screen saver begins
    sudo defaults write com.apple.screensaver askForPassword -int 1
    sudo defaults write com.apple.screensaver askForPasswordDelay -int 0
    sudo defaults write com.apple.screensaver moduleDic -array-add\
    '<dict><key>path</key><string>/System/Library/Screen Savers/Computer Name.saver</string>
    	<key>displayName</key><string>Computer Name</string>
    	<key>moduleName</key><string>Computer Name</string>
    	<key>type</key><int>0</int></dict>'

#### com.apple.SoftwareUpdate ####
	
	sudo defaults write com.apple.softwareupdate CriticalUpdateInstall -bool true
	sudo defaults write com.apple.softwareupdate PrimaryLanguages "(fr-CH,fr)"
	sudo defaults write com.apple.softwareupdate AutomaticCheckEnabled -bool false

#### com.apple.systemuiserver ####
	
	sudo defaults write com.apple.systemuiserver menuExtras "(/System/Library/CoreServices/Menu Extras/Displays.menu, /System/Library/CoreServices/Menu Extras/Volume.menu, /System/Library/CoreServices/Menu Extras/TextInput.menu, /System/Library/CoreServices/Menu Extras/Clock.menu)"


#### TIME MACHINE ####

    # Preventing Time Machine from prompting to use new hard drives as backup volume
    sudo defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true
    
    # Disabling local Time Machine backups
    hash tmutil &> /dev/null && sudo tmutil disablelocal

#### Office 2016 ####
	
	# Disable first run setup
 	sudo defaults write /Library/Preferences/com.microsoft.Word kSubUIAppCompletedFirstRunSetup1507 -bool true
 	sudo defaults write /Library/Preferences/com.microsoft.Outlook kSubUIAppCompletedFirstRunSetup1507 -bool true
 	sudo defaults write /Library/Preferences/com.microsoft.PowerPoint kSubUIAppCompletedFirstRunSetup1507 -bool true
 	sudo defaults write /Library/Preferences/com.microsoft.Excel kSubUIAppCompletedFirstRunSetup1507 -bool true
 	sudo defaults write /Library/Preferences/com.microsoft.onenote.mac kSubUIAppCompletedFirstRunSetup1507 -bool true
 	
 	# Disable updater
 	# echo "Remove Microsoft Office 2016 Updater App"
	if [ -d /Library/Application\ Support/Microsoft/MAU2.0 ] 
	then
	    # echo "Directory /Library/Application\ Support/Microsoft/MAU2.0  exists." 
	    sudo rm -R /Library/Application\ Support/Microsoft/MAU2.0
	fi
	rm -rf /Library/Application\ Support/Microsoft\ AU\ Daemon
	rm -rf /Library/LaunchDaemons/com.microsoft.autoupdate.helper.plist
	rm -rf /Library/LaunchAgents/com.microsoft.update.agent.plist
	rm -rf /Library/LaunchDaemons/com.microsoft.OneDriveUpdaterDaemon.plist

#### Adobe CC 2018 ####
	
	launchctl remove /Library/LaunchAgents/com.adobe.AdobeCreativeCloud.plist
	rm -Rf /Library/LaunchAgents/com.adobe.AdobeCreativeCloud.plist

#### SSH ####

	if [ "$localAdminUsername" != "" ]; then
	
		# Active la session à distance SSH
		sudo systemsetup -f -setremotelogin on

		# Créer le groupe access_ssh avec l’API Open Directory (le recréé si déjà créé)
		sudo dseditgroup -o create -q com.apple.access_ssh
  
		# Ajouter le user $targetUsername à ce groupe.
		# Cette commande active aussi automatiquement le bouton radio « Session à distance » / « Autoriser l’accès pour Uniquement ces utilisateurs »
		sudo dseditgroup -o edit -a $localAdminUsername -T group com.apple.access_ssh

	else
		echo "Error:  The parameter 'localAdminUsername' is blank.  Please specify a user."
	fi


#### ARD ####

	sudo defaults write /Library/Preferences/com.apple.RemoteManagement VNCLegacyConnectionsEnabled -bool false
	sudo defaults write /Library/Preferences/com.apple.RemoteManagement LoadRemoteManagementMenuExtra -bool true
	sudo defaults write /Library/Preferences/com.apple.RemoteManagement ScreenSharingReqPermEnabled -bool false
	sudo defaults write /Library/Preferences/com.apple.RemoteManagement AllowSRPForNetworkNodes -bool false
	sudo defaults write /Library/Preferences/com.apple.RemoteManagement ARD_AllLocalUsersPrivs 1073742079
	# Allow only admin users
	sudo defaults write /Library/Preferences/com.apple.RemoteManagement ARD_AllLocalUsers -bool false
	sudo defaults write /Library/Preferences/com.apple.RemoteManagement DisableKerberos -bool false

	sudo defaults write /Library/Preferences/com.apple.RemoteDesktop ard_admin "(maitres, remplacants, stagiairesa, stagiairesb)"
	sudo defaults write /Library/Preferences/com.apple.RemoteDesktop ard_manage "()"
	sudo defaults write /Library/Preferences/com.apple.RemoteDesktop ard_reports "()"
	sudo defaults write /Library/Preferences/com.apple.RemoteDesktop ard_interact "()"
	sudo defaults write /Library/Preferences/com.apple.RemoteDesktop DOCAllowRemoteConnections -bool false

if [ "$localAdminUsername" != "" ]; then
	# Accorde l’accès à ARD uniquement aux utilisateurs qui ont des privilèges d’accès (donc que à chocolat).
    # Correspond au bouton radio « Gestion à distance » / « Autoriser l’accès pour Uniquement ces utilisateurs »
    # echo "Enabling Apple Remote Desktop Agent..."
	sudo /System/Library/CoreServices/RemoteManagement/ARDAgent.app/Contents/Resources/kickstart -activate -configure -allowAccessFor -specifiedUsers

	# Retire l’accès ARD pour le user 'ucl'
    sudo /System/Library/CoreServices/RemoteManagement/ARDAgent.app/Contents/Resources/kickstart -configure -users ucl -access -off

    # Autorise l’accès ARD pour le user $localAdminUsername avec tous les privilèges d’accès (bouton « Options… » dans l’interface)
    # echo "Setting Remote Management Privileges for User: $localAdminUsername ..."
	sudo /System/Library/CoreServices/RemoteManagement/ARDAgent.app/Contents/Resources/kickstart -configure -users $localAdminUsername -access -on -privs -all
else
	echo "Error:  The parameter 'localAdminUsername' is blank.  Please specify a user."
fi

# defined in setARDManagmentConfig
#
#	if test "$ARD_MANAGED" = "YES"
#	then
#		sudo defaults write /Library/Preferences/com.apple.RemoteManagement DirectoryGroupLoginsEnabled -bool true
#		# echo "Execute sudo defaults write /Library/Preferences/com.apple.RemoteManagement DirectoryGroupLoginsEnabled -bool true"
#	else
#		sudo defaults write /Library/Preferences/com.apple.RemoteManagement DirectoryGroupLoginsEnabled -bool false
#		# echo "Execute sudo defaults write /Library/Preferences/com.apple.RemoteManagement DirectoryGroupLoginsEnabled -bool false"	
#	fi

#### Others ####

    # Disable the sound effects on boot
    sudo nvram SystemAudioVolume=" "
    
    # Restart automatically if the computer freezes
    sudo systemsetup -setrestartfreeze on


############# Configuration pour utilisateurs locaux dans /Users ####################

for UserHome in /Users/*
do
	if test "$UserHome" != "/Users/Shared"; then
		echo "Configuration for local user : $UserHome"

 #### .GlobalPreferences ####

    # Localization setting
    sudo defaults write $UserHome/Library/Preferences/.GlobalPreferences AppleLanguages "(fr-CH,fr,en,de)"
    
    sudo defaults write $UserHome/Library/Preferences/.GlobalPreferences AppleLocale "fr_CH"
    
    sudo defaults write $UserHome/Library/Preferences/.GlobalPreferences AppleTextDirection 0
    
    sudo defaults write $UserHome/Library/Preferences/.GlobalPreferences Country "CH"
    
    sudo defaults write $UserHome/Library/Preferences/.GlobalPreferences MultipleSessionEnabled -bool false
    
    sudo defaults write $UserHome/Library/Preferences/.GlobalPreferences "com.apple.AppleModemSettingTool.LastCountryCode" "CH"
     
    # Keyboard setting
    sudo defaults write $UserHome/Library/Preferences/.GlobalPreferences AppleKeyboardUIMode 3
    
    sudo defaults write $UserHome/Library/Preferences/.GlobalPreferences AppleMeasurementUnits "Centimeter"
    
    sudo defaults write $UserHome/Library/Preferences/.GlobalPreferences AppleMetricUnits -bool true
    
    # Decimal character
    sudo defaults write $UserHome/Library/Preferences/.GlobalPreferences AppleICUNumberSymbols -dict "0" "."
    
    sudo defaults write $UserHome/Library/Preferences/.GlobalPreferences "com.apple.ColorSync.Devices" "/Library/Caches/ColorSync/com.apple.colorsync.devices"
	
	# Disable Resume system-wide
    sudo defaults write $UserHome/Library/Preferences/.GlobalPreferences NSQuitAlwaysKeepsWindows -bool false
    
    # Save to disk (not to iCloud) by default
    sudo defaults write $UserHome/Library/Preferences/.GlobalPreferences NSDocumentSaveNewDocumentsToCloud -bool false
    
    # Expanding the save panel by default
    sudo defaults write $UserHome/Library/Preferences/.GlobalPreferences NSNavPanelExpandedStateForSaveMode -bool true
    
    # Expand print panel by default
    sudo defaults write $UserHome/Library/Preferences/.GlobalPreferences PMPrintingExpandedStateForPrint -bool true
	
	#### com.apple.HIToolbox ####

	# set the "current" keyboard layout
	sudo defaults write $UserHome/Library/Preferences/com.apple.HIToolbox AppleCurrentKeyboardLayoutInputSourceID com.apple.keylayout.SwissFrench
	
	# set the default keyboard
	sudo defaults write $UserHome/Library/Preferences/com.apple.HIToolbox AppleDefaultAsciiInputSource\
    -dict InputSourceKind "Keyboard Layout" "KeyboardLayout ID" -int 18 "KeyboardLayout Name" "Swiss French"
    
    # set the "selected" Input Source
    sudo defaults write $UserHome/Library/Preferences/com.apple.HIToolbox AppleSelectedInputSources -array\
    '<dict><key>InputSourceKind</key><string>Keyboard Layout</string><key>KeyboardLayout ID</key><integer>18</integer><key>KeyboardLayout Name</key><string>Swiss French</string></dict>'

	# set the "enabled" Input Source
    sudo defaults delete "$UserHome/Library/Preferences/"com.apple.HIToolbox AppleEnabledInputSources
    sudo defaults write "$UserHome/Library/Preferences/"com.apple.HIToolbox AppleEnabledInputSources -array-add\
    '<dict><key>InputSourceKind</key><string>Keyboard Layout</string><key>KeyboardLayout ID</key><integer>18</integer><key>KeyboardLayout Name</key><string>Swiss French</string></dict>'

	# enable on-screen keyboard and character viewers
    sudo defaults write $UserHome/Library/Preferences/com.apple.HIToolbox AppleEnabledInputSources -array-add\
    '<dict><key>Bundle ID</key><string>com.apple.CharacterPaletteIM</string><key>InputSourceKind</key><string>Non Keyboard Input Method</string></dict>'
    sudo defaults write $UserHome/Library/Preferences/com.apple.HIToolbox AppleEnabledInputSources -array-add\
    '<dict><key>Bundle ID</key><string>com.apple.KeyboardViewer</string><key>InputSourceKind</key><string>Non Keyboard Input Method</string></dict>'
    sudo defaults write $UserHome/Library/Preferences/com.apple.HIToolbox AppleEnabledInputSources -array-add\
	'<dict><key>Bundle ID</key><string>com.apple.PressAndHold</string><key>InputSourceKind</key><string>Non Keyboard Input Method</string></dict>'
	
	fi
done