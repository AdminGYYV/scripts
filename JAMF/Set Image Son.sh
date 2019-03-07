#!/bin/sh

# Post-install script for "Image Son configurator" 

sudo chmod 644 /Library/LaunchAgents/gyyv.beamertablette.plist

launchctl load -w /Library/LaunchAgents/gyyv.beamertablette.plist