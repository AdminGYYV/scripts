#!/bin/bash

# To get the correct time zone name do a 
# sudo systemsetup -listtimezones

# Set your timezone and ntp server here
TimeZone="Europe/Zurich"
ntpServer="timesrv.vd.ch"

# set the time zone
/usr/sbin/systemsetup -setusingnetworktime off
/usr/sbin/systemsetup -settimezone $TimeZone
/usr/sbin/systemsetup -setusingnetworktime on
/usr/sbin/systemsetup -setnetworktimeserver $ntpServer

# update the time
/usr/sbin/ntpdate -bs $ntpServer
exit 0