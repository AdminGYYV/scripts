#!/bin/sh

# Post-install script for any Adobe app install

# Remove LaunchAgents that were installed

# launchctl remove /Library/LaunchAgents/com.adobe.AAM.Updater-1.0.plist
# launchctl remove com.adobe.ARMDCHelper*

# Delete those plists so they don't load again

# rm -Rf /Library/LaunchAgents/com.adobe.AAM.Updater-1.0.plist
# rm -Rf /Library/LaunchAgents/com.adobe.ARMDCHelper*

# Remove LaunchDaemons that were installed

# launchctl remove /Library/LaunchDaemons/com.adobe.adobeupdatedaemon.plist
# launchctl remove /Library/LaunchDaemons/com.adobe.adobeupdatedaemon.plist
# launchctl remove /Library/LaunchDaemons/com.adobe.ARMDC.Communicator.plist
# launchctl remove /Library/LaunchDaemons/com.adobe.ARMDC.SMJobBlessHelper.plist

# Delete those plists so they don't load again on reboot

# rm -Rf /Library/LaunchDaemons/com.adobe.adobeupdatedaemon.plist
# rm -Rf /Library/LaunchDaemons/com.adobe.adobeupdatedaemon.plist
# rm -Rf /Library/LaunchDaemons/com.adobe.ARMDC.Communicator.plist
# rm -Rf /Library/LaunchDaemons/com.adobe.ARMDC.SMJobBlessHelper.plist

# Added gyyv

launchctl remove /Library/LaunchAgents/com.adobe.AdobeCreativeCloud.plist
rm -Rf /Library/LaunchAgents/com.adobe.AdobeCreativeCloud.plist

# launchctl remove /Library/LaunchDaemons/com.adobe.agsservice.plist
# rm -Rf /Library/LaunchDaemons/com.adobe.agsservice.plist


exit 0