#!/bin/bash

## Users settings for Network users
##
## Parameters :
##
## v1.0 - cedrdelm - 09.10.2018 - merge many different scripts
##									set_GlobalPreferences_userLevel_HighSierra
##									Set Microsoft Office 2016 autoUpdate to Manual (network user or local user)
##									symlink_redirector
##									set_userPref HighSierra (test)
##

Version="1.0"


echo "User setting v."$Version

LoggedInUser=$3
echo "User : $LoggedInUser"

isUserLocal=$(dscl /Search -read /Users/$USER | grep AppleMetaNodeLocation | cut -d / -f 2)
isUserLocalNetwork=$(dscl /Search -read /UsersTmp/$USER | grep AppleMetaNodeLocation | cut -d / -f 2)

# Local user
if [[ $isUserLocal == Local ]]
then
    LoggedInUserHome="/Users/"$LoggedInUser
    isNetworkUser=false
# Local user
elif [[ $isUserLocal == Local ]]
then
	LoggedInUserHome="/UsersTmp/"$LoggedInUser
	isNetworkUser=false
# Network User
else
    LoggedInUserHome=$(eval echo ~$LoggedInUser)
    isNetworkUser=true
fi

echo "Path : $LoggedInUserHome"

date_plb="Mon Jun 01 00:00:01 2018"

#########################################################
if [[ $isUserLocal == Local ]]
	then

	#### .GlobalPreferences ####
	
		# Localization setting
		sudo defaults write $LoggedInUserHome/Library/Preferences/.GlobalPreferences AppleLanguages "(fr-CH,fr,en,de,it,es,it,pt,nl)"
		
		sudo defaults write $LoggedInUserHome/Library/Preferences/.GlobalPreferences AppleLocale "fr_CH"
	
		sudo defaults write $LoggedInUserHome/Library/Preferences/.GlobalPreferences AppleTextDirection 0
	
		sudo defaults write $LoggedInUserHome/Library/Preferences/.GlobalPreferences Country "CH"
	
		sudo defaults write $LoggedInUserHome/Library/Preferences/.GlobalPreferences MultipleSessionEnabled -bool false
	
		sudo defaults write $LoggedInUserHome/Library/Preferences/.GlobalPreferences "com.apple.AppleModemSettingTool.LastCountryCode" "CH"
	
		sudo defaults write $LoggedInUserHome/Library/Preferences/.GlobalPreferences AppleKeyboardUIMode 3
	
		sudo defaults write $LoggedInUserHome/Library/Preferences/.GlobalPreferences AppleMeasurementUnits "Centimeter"
	
		sudo defaults write $LoggedInUserHome/Library/Preferences/.GlobalPreferences AppleMetricUnits -bool true
	
		sudo defaults write $LoggedInUserHome/Library/Preferences/.GlobalPreferences AppleICUNumberSymbols -dict "0" "."
  
		sudo defaults write $LoggedInUserHome/Library/Preferences/.GlobalPreferences AppleCollationOrder "fr-CA"  
  
		sudo defaults write $LoggedInUserHome/Library/Preferences/.GlobalPreferences "com.apple.ColorSync.Devices" "/Library/Caches/ColorSync/com.apple.colorsync.devices"
	
		# Apps, disable App Nap for all apps
		sudo defaults write $LoggedInUserHome/Library/Preferences/.GlobalPreferences NSAppSleepDisabled -bool true
		#echo "NSAppSleepDisabled ok"

	
		#File save, expand save panel by default
		sudo defaults write $LoggedInUserHome/Library/Preferences/.GlobalPreferences NSNavPanelExpandedStateForSaveMode -bool true
		#echo "NSNavPanelExpandedStateForSaveMode ok"
		sudo defaults write $LoggedInUserHome/Library/Preferences/.GlobalPreferences NSNavPanelExpandedStateForSaveMode2 -bool true
		#echo "NSNavPanelExpandedStateForSaveMode2 ok"
	
		# File save, save to disk by default rather than to iCloud
		sudo defaults write $LoggedInUserHome/Library/Preferences/.GlobalPreferences NSDocumentSaveNewDocumentsToCloud -bool false
		#echo "NSDocumentSaveNewDocumentsToCloud ok"

		# Interface, disable opening and closing window animations
		sudo defaults write $LoggedInUserHome/Library/Preferences/.GlobalPreferences NSAutomaticWindowAnimationsEnabled -bool false
		#echo "NSAutomaticWindowAnimationsEnabled ok"
	
		# Interface, quit always saves windows
		defaults write $LoggedInUserHome/Library/Preferences/.GlobalPreferences NSQuitAlwaysKeepsWindows -bool false
		defaults write $LoggedInUserHome/Library/Preferences/com.apple.systempreferences NSQuitAlwaysKeepsWindows -bool false
		#echo "NSQuitAlwaysKeepsWindows ok"
	
		# Print, expand print panel by default
		defaults write $LoggedInUserHome/Library/Preferences/.GlobalPreferences PMPrintingExpandedStateForPrint -bool true 
		#echo "PMPrintingExpandedStateForPrint ok"
		defaults write $LoggedInUserHome/Library/Preferences/.GlobalPreferences PMPrintingExpandedStateForPrint2 -bool true
		#echo "PMPrintingExpandedStateForPrint2 ok"
	
		#Sound, disable flash with system beep
		defaults write $LoggedInUserHome/Library/Preferences/.GlobalPreferences com.apple.sound.beep.flash -bool false
		#echo "com.apple.sound.beep.flash ok"
	
		####################################
		# Auto-correction, completion ...
		####################################
		# Text, disable auto-correct
		sudo defaults write $LoggedInUserHome/Library/Preferences/.GlobalPreferences NSAutomaticSpellingCorrectionEnabled -bool false

		# Text, disable automatic capitalisation
		sudo defaults write $LoggedInUserHome/Library/Preferences/.GlobalPreferences NSAutomaticCapitalizationEnabled -bool false

		# Text, disable automatic period substitution
		sudo defaults write $LoggedInUserHome/Library/Preferences/.GlobalPreferences NSAutomaticPeriodSubstitutionEnabled -bool false

		# Text, disable automatic text completion
		sudo defaults write $LoggedInUserHome/Library/Preferences/.GlobalPreferences NSAutomaticTextCompletionEnabled -bool false

		# Text, disable smart dashes
		sudo defaults write $LoggedInUserHome/Library/Preferences/.GlobalPreferences NSAutomaticDashSubstitutionEnabled -bool false

		# Text, disable smart quotes
		sudo defaults write $LoggedInUserHome/Library/Preferences/.GlobalPreferences NSAutomaticQuoteSubstitutionEnabled -bool false

		# Text, disable web automatic spelling correction
		sudo defaults write $LoggedInUserHome/Library/Preferences/.GlobalPreferences WebAutomaticSpellingCorrectionEnabled -bool false

		# Text, display ASCII control characters using caret notation in standard text views
		sudo defaults write $LoggedInUserHome/Library/Preferences/.GlobalPreferences NSTextShowsControlCharacters -bool true

		# Text, spell checker automatically identifies languages
		sudo defaults write $LoggedInUserHome/Library/Preferences/.GlobalPreferences NSSpellCheckerAutomaticallyIdentifiesLanguages -bool true

	#### com.apple.commerce ####
		# Turn off app auto-update
		defaults write $LoggedInUserHome/Library/Preferences/com.apple.commerce AutoUpdate -bool false
	
		# Allow the App Store to reboot machine on macOS updates
		defaults write $LoggedInUserHome/Library/Preferences/com.apple.commerce AutoUpdateRestartRequired -bool true

	#### com.apple.CrashReporter ####
		# Disable the crash reporter
		defaults write $LoggedInUserHome/Library/Preferences/com.apple.CrashReporter DialogType -string "none"

	#### com.apple.desktopservices ####
		# Speedup browsing in network share
		# Avoid creating .DS_Store files on network or USB volumes
		sudo defaults write $LoggedInUserHome/com.apple.desktopservices DSDontWriteNetworkStores -bool true
		sudo defaults write $LoggedInUserHome/Library/Preferences/com.apple.desktopservices DSDontWriteUSBStores -bool true

	#### com.apple.finder ####

		# Finder: allow quitting via ⌘ + Q; doing so will also hide desktop icons
		defaults write $LoggedInUserHome/Library/Preferences/com.apple.finder QuitMenuItem -bool true

		# Finder: disable window animations and Get Info animations
		defaults write $LoggedInUserHome/Library/Preferences/com.apple.finder DisableAllAnimations -bool true

		# Set HomeDir as the default location for new Finder windows
		# For other paths, use `PfLo` and `file:///full/path/here/`
		defaults write $LoggedInUserHome/Library/Preferences/com.apple.finder NewWindowTarget -string "PfDe"
		defaults write $LoggedInUserHome/Library/Preferences/com.apple.finder NewWindowTargetPath -string "$LoggedInUserHome"

		# Show icons for hard drives, servers, and removable media on the desktop
		defaults write $LoggedInUserHome/Library/Preferences/com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
		defaults write $LoggedInUserHome/Library/Preferences/com.apple.finder ShowHardDrivesOnDesktop -bool false
		defaults write $LoggedInUserHome/Library/Preferences/com.apple.finder ShowMountedServersOnDesktop -bool true
		defaults write $LoggedInUserHome/Library/Preferences/com.apple.finder ShowRemovableMediaOnDesktop -bool true

		# Keep folders on top when sorting by name
		defaults write $LoggedInUserHome/Library/Preferences/com.apple.finder _FXSortFoldersFirst -bool true

		# When performing a search, search the current folder by default
		defaults write $LoggedInUserHome/Library/Preferences/com.apple.finder FXDefaultSearchScope -string "SCcf"
	
		# Automatically open a new Finder window when a volume is mounted
		defaults write $LoggedInUserHome/Library/Preferences/com.apple.finder OpenWindowForNewRemovableDisk -bool true
	
		# Use columns view in all Finder windows by default
		# Four-letter codes for the other view modes: `icnv`, `clmv`, `Flwv`, Nlws
		defaults write $LoggedInUserHome/Library/Preferences/com.apple.finder FXPreferredViewStyle -string "clmv"

	#### com.apple.frameworks.diskimages ####
		# Automatically open a new Finder window when a volume is mounted
		defaults write $LoggedInUserHome/Library/Preferences/com.apple.frameworks.diskimages auto-open-ro-root -bool true
		defaults write $LoggedInUserHome/Library/Preferences/com.apple.frameworks.diskimages auto-open-rw-root -bool true

	#### com.apple.com.apple.LaunchServices ####
		# Apps, disable the “Are you sure you want to open this application?” dialog
		sudo defaults write $LoggedInUserHome/Library/Preferences/com.apple.LaunchServices LSQuarantine -bool false

	#### com.apple.NetworkBrowser ####	
		# Disable AirDrop over Ethernet and on unsupported Macs running Lion
		defaults write $LoggedInUserHome/Library/Preferences/com.apple.NetworkBrowser BrowseAllInterfaces -bool false

	#### com.apple.Safari ####

		sudo defaults write $LoggedInUserHome/Library/Preferences/com.apple.Safari ManagedPlugInPolicies -array-add\
	
	#### com.apple.SoftwareUpdate ####
		# Disable the automatic update check
		defaults write $LoggedInUserHome/Library/Preferences/com.apple.SoftwareUpdate AutomaticCheckEnabled -bool false

	#### com.apple.systempreferences ####
	
		sudo defaults write $LoggedInUserHome/Library/Preferences/com.apple.systempreferences BluetoothAutoSeekKeyboard -bool false

		sudo defaults write $LoggedInUserHome/Library/Preferences/com.apple.systempreferences BluetoothAutoSeekPointingDevice -bool false

	#### com.apple.TimeMachine ####
		# Prevent Time Machine from prompting to use new hard drives as backup volume
		defaults write $LoggedInUserHome/Library/Preferences/com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true

	#### com.google.Chrome ####
		# Use the system-native print preview dialog
		defaults write $LoggedInUserHome/Library/Preferences/com.google.Chrome DisablePrintPreview -bool true
		defaults write $LoggedInUserHome/Library/Preferences/com.google.Chrome.canary DisablePrintPreview -bool true
	
		# Expand the print dialog by default
		defaults write $LoggedInUserHome/Library/Preferences/com.google.Chrome PMPrintingExpandedStateForPrint2 -bool true
		defaults write $LoggedInUserHome/Library/Preferences/com.google.Chrome.canary PMPrintingExpandedStateForPrint2 -bool true

	#### com.microsoft.autoupdate2 ####
		date_str=$(date +"%Y-%m-%d %H:%M:%S +0000")
		# echo $date_str
		sudo defaults write $LoggedInUserHome/Library/Preferences/com.microsoft.autoupdate2 HowToCheck -string 'Manual'
		sudo defaults write $LoggedInUserHome/Library/Preferences/com.microsoft.autoupdate2 LastUpdate -date "$date_str"

	########## Notification Center
		# Disable Notification Center and remove the menu bar icon
		launchctl unload -w /System/Library/LaunchAgents/com.apple.notificationcenterui.plist 2> /dev/null	

	###############################################################################
	# Kill affected applications                                                  #
	###############################################################################

	for app in "Finder" \
	   "Activity Monitor";
		do
		killall "${app}" &> /dev/null
		echo "${app} relauched \n" >> $File
	done

	########## Redirections for network users #############

	if [[ $isUserLocal == Local ]]
	then
		echo "Local user : no redirection to be created"
	else

		#su $LoggedInUser

		if [ ! -d /private/tmp/$LoggedInUser/Library/Application\ Support/Adobe ] 
		then
			sudo -u $LoggedInUser mkdir /private/tmp/$LoggedInUser/ 
			sudo -u $LoggedInUser mkdir /private/tmp/$LoggedInUser/Library/ 
			sudo -u $LoggedInUser mkdir /private/tmp/$LoggedInUser/Library/Application\ Support/ 
			sudo -u $LoggedInUser mkdir /private/tmp/$LoggedInUser/Library/Application\ Support/Adobe/ 
			echo "Created /Application Support/Adobe ..." 
		fi

		if [ ! -d /private/tmp/$LoggedInUser/Library/Caches/Adobe\ Camera\ Raw ] 
		then
			sudo -u $LoggedInUser mkdir /private/tmp/$LoggedInUser/Library/Caches/ 
			sudo -u $LoggedInUser mkdir /private/tmp/$LoggedInUser/Library/Caches/Adobe/ 
			sudo -u $LoggedInUser mkdir /private/tmp/$LoggedInUser/Library/Caches/Adobe\ Camera\ Raw/
			echo "Created /Caches/Adobe Camera Raw ..." 
		fi

		if [ ! -d /private/tmp/$LoggedInUser/Library/Caches/Bibliomaker\ Client ] 
		then
			sudo -u $LoggedInUser mkdir /private/tmp/$LoggedInUser/Library/Application\ Support/Bibliomaker\ Client/ 
			sudo -u $LoggedInUser mkdir /private/tmp/$LoggedInUser/Library/Caches/Bibliomaker\ Client/
			echo "Created /Caches/Bibliomaker Client ..." 
		fi

		if [ ! -d /private/tmp/$LoggedInUser/Library/Caches/Meta ] 
		then
			sudo -u $LoggedInUser mkdir /private/tmp/$LoggedInUser/Library/Caches/Meta/ 
			echo "Created /Caches/Meta ..." 
		fi


		#test redirection pour Office par cde   
		if [ ! -d /private/tmp/$LoggedInUser/Library/Containers ] 
			echo "/private/tmp/$LoggedInUser/Library/Containers already exists"
		then
			sudo -u $LoggedInUser mkdir /private/tmp/$LoggedInUser/Library/Containers/
			echo "/private/tmp/$LoggedInUser/Library/Containers created"
		fi

		if [ ! -d /private/tmp/$LoggedInUser/Library/Containers/com.microsoft.Excel/Data/Library/Caches ] 
		then
			sudo -u $LoggedInUser mkdir /private/tmp/$LoggedInUser/Library/Containers/com.microsoft.Excel
			sudo -u $LoggedInUser mkdir /private/tmp/$LoggedInUser/Library/Containers/com.microsoft.Excel/Data
			sudo -u $LoggedInUser mkdir /private/tmp/$LoggedInUser/Library/Containers/com.microsoft.Excel/Data/Library
			sudo -u $LoggedInUser mkdir /private/tmp/$LoggedInUser/Library/Containers/com.microsoft.Excel/Data/Library/Caches
		fi

		if [ ! -d /private/tmp/$LoggedInUser/Library/Containers/com.microsoft.Word/Data/Library/Caches ] 
		then
			sudo -u $LoggedInUser mkdir /private/tmp/$LoggedInUser/Library/Containers/com.microsoft.Word
			sudo -u $LoggedInUser mkdir /private/tmp/$LoggedInUser/Library/Containers/com.microsoft.Word/Data
			sudo -u $LoggedInUser mkdir /private/tmp/$LoggedInUser/Library/Containers/com.microsoft.Word/Data/Library
			sudo -u $LoggedInUser mkdir /private/tmp/$LoggedInUser/Library/Containers/com.microsoft.Word/Data/Library/Caches
		fi

		if [ ! -d /private/tmp/$LoggedInUser/Library/Containers/com.microsoft.PowerPoint/Data/Library/Caches ] 
		then
			sudo -u $LoggedInUser mkdir /private/tmp/$LoggedInUser/Library/Containers/com.microsoft.PowerPoint
			sudo -u $LoggedInUser mkdir /private/tmp/$LoggedInUser/Library/Containers/com.microsoft.PowerPoint/Data
			sudo -u $LoggedInUser mkdir /private/tmp/$LoggedInUser/Library/Containers/com.microsoft.PowerPoint/Data/Library
			sudo -u $LoggedInUser mkdir /private/tmp/$LoggedInUser/Library/Containers/com.microsoft.PowerPoint/Data/Library/Caches
		fi

		if [ ! -d /private/tmp/$LoggedInUser/Library/Containers/com.microsoft.Office365ServiceV2/Data/Library/Caches ] 
		then
			sudo -u $LoggedInUser mkdir /private/tmp/$LoggedInUser/Library/Containers/com.microsoft.Office365ServiceV2
			sudo -u $LoggedInUser mkdir /private/tmp/$LoggedInUser/Library/Containers/com.microsoft.Office365ServiceV2/Data
			sudo -u $LoggedInUser mkdir /private/tmp/$LoggedInUser/Library/Containers/com.microsoft.Office365ServiceV2/Data/Library
			sudo -u $LoggedInUser mkdir /private/tmp/$LoggedInUser/Library/Containers/com.microsoft.Office365ServiceV2/Data/Library/Caches
		fi
		###
	
		# Ajout sur conseil de Matt Weber
	
		if [ ! -d $LoggedInUser/.TemporaryItems ] 
		then
			sudo mkdir $LoggedInUserHome/.TemporaryItems
			sudo chown $LoggedInUser $LoggedInUserHome/.TemporaryItems
			sudo chmod 777 $LoggedInUserHome/.TemporaryItems
		fi

		# Delete and Create Symlinks
		#if [ ! -L $LoggedInUserHome/Library/Application\ Support/Adobe ]
		#then 
			echo "Creating non-existing symbolic links..." 
	
			su

		if [ ! -L $LoggedInUserHome/Library/Application\ Support/Adobe ]
		then 
			sudo rm -Rf $LoggedInUserHome/Library/Application\ Support/Adobe
			ln -s /private/tmp/$LoggedInUser/Library/Application\ Support/Adobe $LoggedInUserHome/Library/Application\ Support
		fi

		if [ ! -L $LoggedInUserHome/Library/Caches/Adobe ]
		then 
			sudo rm -Rf $LoggedInUserHome/Library/Caches/Adobe
			ln -s /private/tmp/$LoggedInUser/Library/Caches/Adobe $LoggedInUserHome/Library/Caches
		fi

		if [ ! -L $LoggedInUserHome/Library/Caches/Adobe\ Camera\ Raw ]
		then 
			sudo rm -Rf $LoggedInUserHome/Library/Caches/Adobe\ Camera\ Raw 
			ln -s /private/tmp/$LoggedInUser/Library/Caches/Adobe\ Camera\ Raw  $LoggedInUserHome/Library/Caches
		fi

		if [ ! -L $LoggedInUserHome/Library/Application\ Support/Bibliomaker\ Client ]
		then 
			sudo rm -Rf $LoggedInUserHome/Library/Application\ Support/Bibliomaker\ Client
			ln -s /private/tmp/$LoggedInUser/Library/Application\ Support/Bibliomaker\ Client $LoggedInUserHome/Library/Application\ Support
		fi

		if [ ! -L $LoggedInUserHome/Library/Caches/Bibliomaker\ Client ]
		then 
			sudo rm -Rf $LoggedInUserHome/Library/Caches/Bibliomaker\ Client
			ln -s /private/tmp/$LoggedInUser/Library/Caches/Bibliomaker\ Client $LoggedInUserHome/Library/Caches
		fi

		if [ ! -L $LoggedInUserHome/Library/Caches/Meta ]
		then 
			sudo rm -Rf $LoggedInUserHome/Library/Caches/Meta
			ln -s /private/tmp/$LoggedInUser/Library/Caches/Meta $LoggedInUserHome/Library/Caches
		fi
	
		#test redirection pour Office par cde
		if [ -d $LoggedInUserHome/Library/Containers/com.microsoft.Excel/Data/Library/Caches ] 
		then
			sudo rm -Rf $LoggedInUserHome/Library/Containers/com.microsoft.Excel/Data/Library/Caches
			ln -s /private/tmp/$LoggedInUser/Library/Containers/com.microsoft.Excel/Data/Library/Caches $LoggedInUserHome/Library/Containers/com.microsoft.Excel/Data/Library
		fi

		if [ -d $LoggedInUserHome/Library/Containers/com.microsoft.Word/Data/Library/Caches ] 
		then
			sudo rm -Rf $LoggedInUserHome/Library/Containers/com.microsoft.Word/Data/Library/Caches
			ln -s /private/tmp/$LoggedInUser/Library/Containers/com.microsoft.Word/Data/Library/Caches $LoggedInUserHome/Library/Containers/com.microsoft.Word/Data/Library
		fi

		if [ -d $LoggedInUserHome/Library/Containers/com.microsoft.PowerPoint/Data/Library/Caches ] 
		then
			sudo rm -Rf $LoggedInUserHome/Library/Containers/com.microsoft.PowerPoint/Data/Library/Caches
			ln -s /private/tmp/$LoggedInUser/Library/Containers/com.microsoft.PowerPoint/Data/Library/Caches $LoggedInUserHome/Library/Containers/com.microsoft.PowerPoint/Data/Library
		fi

		if [ -d $LoggedInUserHome/Library/Containers/com.microsoft.Office365ServiceV2/Data/Library/Caches ]
		then
			sudo rm -Rf $LoggedInUserHome/Library/Containers/com.microsoft.Office365ServiceV2/Data/Library/Caches
			ln -s /private/tmp/$LoggedInUser/Library/Containers/com.microsoft.Office365ServiceV2/Data/Library/Caches $LoggedInUserHome/Library/Containers/com.microsoft.Office365ServiceV2/Data/Library
		fi

	fi

fi
DATE=`date '+%Y-%m-%d %H:%M:%S'`
echo "$DATE Setting pref for user : $LoggedInUser terminated"