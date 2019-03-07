#!/bin/bash

if test "$4" = "YES"
	then
		networksetup -setairportpower Wi-Fi On
	networksetup -setnetworkserviceenabled Wi-Fi On
	else
		networksetup -setairportpower Wi-Fi Off
		networksetup -setnetworkserviceenabled Wi-Fi Off
	fi

