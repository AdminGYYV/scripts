#!/bin/bash

# Gymnase d'Yverdon

# V1.0 - 5 juillet 2018 - CDE
# V1.1 - 11 sept 2018 - CDE (ajout config souris)
# v1.2 - 24 sept 2018 - CDE

# Ce script configure la session du User Template French

# Domaine d'application : script pour Policy JAMF

if test "$4" = ""
then
     UserTemplateLanguage="French"
else
     UserTemplateLanguage=$4	
fi

UserTemplateHome="/System/Library/User Template/$UserTemplateLanguage.lproj"
UserTemplatePreferences="$UserTemplateHome/Library/Preferences"

echo "Current User Template is $UserTemplateHome" 

mkdir "$UserTemplateHome/.log"
echo "Create $UserTemplateHome/.log"

File="$UserTemplateHome/.log/UserTemplateSettings.log"

echo "Log file is : $File"

touch "$File"

DATE=`date '+%Y-%m-%d %H:%M:%S'`
echo "$DATE Setting pref for : $UserTemplateHome" >> "$File"


############################
# Localisation
############################
defaults write "$UserTemplatePreferences/.GlobalPreferences" AppleLanguages "(fr-CH,fr,en,de,it,es,it,pt,nl)"
#echo "AppleLanguage ok"

defaults write "$UserTemplatePreferences/.GlobalPreferences" AppleLocale "fr_CH"
#echo "AppleLocale ok"

defaults write "$UserTemplatePreferences/.GlobalPreferences" AppleTextDirection 0
#echo "AppleTextDirection ok"

defaults write "$UserTemplatePreferences/.GlobalPreferences" Country "CH"
#echo "Country ok"

defaults write "$UserTemplatePreferences/.GlobalPreferences" AppleKeyboardUIMode 3
#echo "AppleKeyboardUIMode ok"

defaults write "$UserTemplatePreferences/.GlobalPreferences" AppleMeasurementUnits "Centimeter"
#echo "AppleMeasurementUnits ok"

defaults write "$UserTemplatePreferences/.GlobalPreferences" AppleTemperatureUnit -string "Celsius"
#echo "AppleTemperatureUnit ok"

defaults write "$UserTemplatePreferences/.GlobalPreferences" AppleMetricUnits -bool true
#echo "AppleMetricUnits ok"

defaults write "$UserTemplatePreferences/.GlobalPreferences" AppleICUNumberSymbols -dict "0" "."
echo "AppleICUNumberSymbols ."

defaults write "$UserTemplatePreferences/.GlobalPreferences" AppleCollationOrder "fr-CH"
echo "Ordre de liste de tri"

echo "Localisation done !"
############################
# Apps
############################

# Apps, disable App Nap for all apps
defaults write "$UserTemplatePreferences/.GlobalPreferences" NSAppSleepDisabled -bool true
#echo "NSAppSleepDisabled ok"

# Apps, disable the “Are you sure you want to open this application?” dialog
defaults write "$UserTemplatePreferences/com.apple.LaunchServices" LSQuarantine -bool false
#echo "LSQuarantine ok"

#File save, expand save panel by default
defaults write "$UserTemplatePreferences/.GlobalPreferences" NSNavPanelExpandedStateForSaveMode -bool true
#echo "NSNavPanelExpandedStateForSaveMode ok"
defaults write "$UserTemplatePreferences/.GlobalPreferences" NSNavPanelExpandedStateForSaveMode2 -bool true
#echo "NSNavPanelExpandedStateForSaveMode2 ok"

# File save, save to disk by default rather than to iCloud
defaults write "$UserTemplatePreferences/.GlobalPreferences" NSDocumentSaveNewDocumentsToCloud -bool false
#echo "NSDocumentSaveNewDocumentsToCloud ok"

# Interface, disable opening and closing window animations
defaults write "$UserTemplatePreferences/.GlobalPreferences" NSAutomaticWindowAnimationsEnabled -bool false
#echo "NSAutomaticWindowAnimationsEnabled ok"

# Interface, quit always saves windows
defaults write "$UserTemplatePreferences/.GlobalPreferences" NSQuitAlwaysKeepsWindows -bool false
defaults write "$UserTemplatePreferences/com.apple.systempreferences" NSQuitAlwaysKeepsWindows -bool false
#echo "NSQuitAlwaysKeepsWindows ok"
#echo "NSQuitAlwaysKeepsWindows ok"

# Print, expand print panel by default
defaults write "$UserTemplatePreferences/.GlobalPreferences" PMPrintingExpandedStateForPrint -bool true 
#echo "PMPrintingExpandedStateForPrint ok"
defaults write "$UserTemplatePreferences/.GlobalPreferences" PMPrintingExpandedStateForPrint2 -bool true
#echo "PMPrintingExpandedStateForPrint2 ok"

#Sound, disable flash with system beep
defaults write "$UserTemplatePreferences/.GlobalPreferences" com.apple.sound.beep.flash -bool false
#echo "com.apple.sound.beep.flash ok"

echo "Apps done !"

####################################
# Auto-correction, completion ...
####################################


# Text, disable auto-correct
defaults write "$UserTemplatePreferences/.GlobalPreferences" NSAutomaticSpellingCorrectionEnabled -bool false

# Text, disable automatic capitalisation
defaults write "$UserTemplatePreferences/.GlobalPreferences" NSAutomaticCapitalizationEnabled -bool false

# Text, disable automatic period substitution
defaults write "$UserTemplatePreferences/.GlobalPreferences" NSAutomaticPeriodSubstitutionEnabled -bool false

# Text, disable automatic text completion
defaults write "$UserTemplatePreferences/.GlobalPreferences" NSAutomaticTextCompletionEnabled -bool false

# Text, disable smart dashes
defaults write "$UserTemplatePreferences/.GlobalPreferences" NSAutomaticDashSubstitutionEnabled -bool false

# Text, disable smart quotes
defaults write "$UserTemplatePreferences/.GlobalPreferences" NSAutomaticQuoteSubstitutionEnabled -bool false

# Text, disable web automatic spelling correction
defaults write "$UserTemplatePreferences/.GlobalPreferences" WebAutomaticSpellingCorrectionEnabled -bool false

# Text, display ASCII control characters using caret notation in standard text views
defaults write "$UserTemplatePreferences/.GlobalPreferences" NSTextShowsControlCharacters -bool true

# Text, spell checker automatically identifies languages
defaults write "$UserTemplatePreferences/.GlobalPreferences" NSSpellCheckerAutomaticallyIdentifiesLanguages -bool true

echo "Auto-correction done !"
####################################

###################
# Finder
###################

# Finder: allow quitting via ⌘ + Q; doing so will also hide desktop icons
defaults write "$UserTemplatePreferences/com.apple.finder" QuitMenuItem -bool true

# Finder: disable window animations and Get Info animations
defaults write "$UserTemplatePreferences/com.apple.finder" DisableAllAnimations -bool true

if test "$5" = "TE"
then
  # Set HomeDir as the default location for new Finder windows
  # For other paths, use `PfLo` and `file:///full/path/here/`
  defaults write "$UserTemplatePreferences/com.apple.finder" NewWindowTarget -string "PfLo"
  defaults write "$UserTemplatePreferences/com.apple.finder" NewWindowTargetPath -string "/Volumes"

else

  # Set HomeDir as the default location for new Finder windows
  # For other paths, use `PfLo` and `file:///full/path/here/`
  defaults write "$UserTemplatePreferences/com.apple.finder" NewWindowTarget -string "PfLo"
  defaults write "$UserTemplatePreferences/com.apple.finder" NewWindowTargetPath -string "~/Desktop"
  
 fi

# Show icons for hard drives, servers, and removable media on the desktop
defaults write "$UserTemplatePreferences/com.apple.finder" ShowExternalHardDrivesOnDesktop -bool false
defaults write "$UserTemplatePreferences/com.apple.finder" ShowHardDrivesOnDesktop -bool false
defaults write "$UserTemplatePreferences/com.apple.finder" ShowMountedServersOnDesktop -bool true
defaults write "$UserTemplatePreferences/com.apple.finder" ShowRemovableMediaOnDesktop -bool true

# Keep folders on top when sorting by name
defaults write "$UserTemplatePreferences/com.apple.finder" _FXSortFoldersFirst -bool true

# When performing a search, search the current folder by default
defaults write "$UserTemplatePreferences/com.apple.finder" FXDefaultSearchScope -string "SCcf"

# Avoid creating .DS_Store files on network or USB volumes
defaults write "$UserTemplatePreferences/com.apple.desktopservices" DSDontWriteNetworkStores -bool true
defaults write "$UserTemplatePreferences/com.apple.desktopservices" DSDontWriteUSBStores -bool true

# Automatically open a new Finder window when a volume is mounted
defaults write "$UserTemplatePreferences/com.apple.frameworks.diskimages" auto-open-ro-root -bool true
defaults write "$UserTemplatePreferences/com.apple.frameworks.diskimages" auto-open-rw-root -bool true
defaults write "$UserTemplatePreferences/com.apple.finder" OpenWindowForNewRemovableDisk -bool true

# Use columns view in all Finder windows by default
# Four-letter codes for the other view modes: `icnv`, `clmv`, `Flwv`, Nlws
defaults write "$UserTemplatePreferences/com.apple.finder" FXPreferredViewStyle -string "clmv"

# Disable AirDrop over Ethernet and on unsupported Macs running Lion
defaults write "$UserTemplatePreferences/com.apple.NetworkBrowser" BrowseAllInterfaces -bool false

echo "Finder done !"
###################

###################
# BlueTooth
###################
defaults write "$UserTemplatePreferences/com.apple.systempreferences" BluetoothAutoSeekKeyboard -bool false

defaults write "$UserTemplatePreferences/com.apple.systempreferences" BluetoothAutoSeekPointingDevice -bool false


###################
# Mouse
###################
sudo defaults write "$UserTemplatePreferences/com.apple.driver.AppleHIDMouse" Button2 -int 2



###################
# Mac App Store
###################
# Enable the automatic update check
defaults write "$UserTemplatePreferences/com.apple.SoftwareUpdate" AutomaticCheckEnabled -bool false

# Turn off app auto-update
defaults write "$UserTemplatePreferences/com.apple.commerce" AutoUpdate -bool false

# Allow the App Store to reboot machine on macOS updates
defaults write "$UserTemplatePreferences/com.apple.commerce" AutoUpdateRestartRequired -bool true

echo "App Store done !"
###################

# Speedup browsing in network share (v1.2)
defaults write "$UserTemplatePreferences/com.apple.desktopservices" DSDontWriteNetworkStores -bool TRUE

# Disable the crash reporter
defaults write "$UserTemplatePreferences/com.apple.CrashReporter" DialogType -string "none"


# Disable Notification Center and remove the menu bar icon
# launchctl unload -w /System/Library/LaunchAgents/com.apple.notificationcenterui.plist 2> /dev/null

# Set a custom wallpaper image. `DefaultDesktop.jpg` is already a symlink, and
# all wallpapers are in `/Library/Desktop Pictures/`. The default is `Wave.jpg`.
#rm -rf ~/Library/Application Support/Dock/desktoppicture.db
#sudo rm -rf /System/Library/CoreServices/DefaultDesktop.jpg
#sudo ln -s /path/to/your/image /System/Library/CoreServices/DefaultDesktop.jpg

# Prevent Time Machine from prompting to use new hard drives as backup volume
defaults write "$UserTemplatePreferences/com.apple.TimeMachine" DoNotOfferNewDisksForBackup -bool true

# Disable local Time Machine backups
#hash tmutil &> /dev/null && sudo tmutil disablelocal

# Use the system-native print preview dialog
defaults write "$UserTemplatePreferences/com.google.Chrome" DisablePrintPreview -bool true
defaults write "$UserTemplatePreferences/com.google.Chrome.canary" DisablePrintPreview -bool true

# Expand the print dialog by default
defaults write "$UserTemplatePreferences/com.google.Chrome" PMPrintingExpandedStateForPrint2 -bool true
defaults write "$UserTemplatePreferences/com.google.Chrome.canary" PMPrintingExpandedStateForPrint2 -bool true

echo "Other done !"

DATE=`date '+%Y-%m-%d %H:%M:%S'`
echo "$DATE Setting pref for : $UserTemplateHome terminated" >> "$File"