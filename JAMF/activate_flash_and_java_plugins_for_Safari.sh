#!/bin/sh

echo "script Activate_flash_and_java_plugins_for_Safari"

LoggedInUser=$3
echo "User : $LoggedInUser"

isUserLocal=$(dscl /Search -read /Users/$USER | grep AppleMetaNodeLocation | cut -d / -f 2)

# Local user
if [[ $isUserLocal == Local ]]
then
    LoggedInUserHome="/Users/"$LoggedInUser

# Network User
else
    LoggedInUserHome=$(eval echo ~$LoggedInUser)
fi

echo "Path : $LoggedInUserHome"

date_plb="Mon Jun 01 00:00:01 2018"

plist_str="$LoggedInUserHome/Library/Preferences/com.apple.Safari.plist"
echo "plist_str=$plist_str"

declare -a arr=(":ManagedPlugInPolicies:com.oracle.java.JavaAppletPlugin" ":ManagedPlugInPolicies:com.macromedia.Flash\ Player.plugin")

for struct_str in "${arr[@]}"
do
	# Delete plugin structure
	/usr/libexec/PlistBuddy -c "delete $struct_str" "$plist_str"   

	# Then reconstruct it
	/usr/libexec/PlistBuddy -c "add $struct_str dict" "$plist_str"     
	/usr/libexec/PlistBuddy -c "add $struct_str:PlugInFirstVisitPolicy string PlugInPolicyBlock" "$plist_str"
	/usr/libexec/PlistBuddy -c "add $struct_str:PlugInHostnamePolicies array" "$plist_str"     

	struct_str="$struct_str:PlugInHostnamePolicies"

	/usr/libexec/PlistBuddy -c "add $struct_str: dict" "$plist_str"   
	/usr/libexec/PlistBuddy -c "add $struct_str:0:PlugInHostname string www.taptouche.com" "$plist_str"
	/usr/libexec/PlistBuddy -c "add $struct_str:0:PlugInLastVisitedDate date $date_plb" "$plist_str"
	/usr/libexec/PlistBuddy -c "add $struct_str:0:PlugInPageURL string \"http://www.taptouche.com/\"" "$plist_str"
	/usr/libexec/PlistBuddy -c "add $struct_str:0:PlugInPolicy string PlugInPolicyAllowWithSecurityRestrictions" "$plist_str"
	/usr/libexec/PlistBuddy -c "add $struct_str:0:PlugInRunUnsandboxed bool false" "$plist_str"

	/usr/libexec/PlistBuddy -c "add $struct_str: dict" "$plist_str"   
	/usr/libexec/PlistBuddy -c "add $struct_str:1:PlugInHostname string admin.taptouche.com" "$plist_str"
	/usr/libexec/PlistBuddy -c "add $struct_str:1:PlugInLastVisitedDate date $date_plb" "$plist_str"
	/usr/libexec/PlistBuddy -c "add $struct_str:1:PlugInPageURL string \"https://admin.taptouche.com/\"" "$plist_str"
	/usr/libexec/PlistBuddy -c "add $struct_str:1:PlugInPolicy string PlugInPolicyAllowWithSecurityRestrictions" "$plist_str"
	/usr/libexec/PlistBuddy -c "add $struct_str:1:PlugInRunUnsandboxed bool false" "$plist_str"

	/usr/libexec/PlistBuddy -c "add $struct_str: dict" "$plist_str"   
	/usr/libexec/PlistBuddy -c "add $struct_str:2:PlugInHostname string ecole.taptouche.com" "$plist_str"
	/usr/libexec/PlistBuddy -c "add $struct_str:2:PlugInLastVisitedDate date $date_plb" "$plist_str"
	/usr/libexec/PlistBuddy -c "add $struct_str:2:PlugInPageURL string \"https://ecole.taptouche.com/\"" "$plist_str"
	/usr/libexec/PlistBuddy -c "add $struct_str:2:PlugInPolicy string PlugInPolicyAllowWithSecurityRestrictions" "$plist_str"
	/usr/libexec/PlistBuddy -c "add $struct_str:2:PlugInRunUnsandboxed bool false" "$plist_str"

	/usr/libexec/PlistBuddy -c "add $struct_str: dict" "$plist_str"   
	/usr/libexec/PlistBuddy -c "add $struct_str:3:PlugInHostname string www.projet-voltaire.fr" "$plist_str"
	/usr/libexec/PlistBuddy -c "add $struct_str:3:PlugInLastVisitedDate date $date_plb" "$plist_str"
	/usr/libexec/PlistBuddy -c "add $struct_str:3:PlugInPageURL string \"https://www.projet-voltaire.fr/\"" "$plist_str"
	/usr/libexec/PlistBuddy -c "add $struct_str:3:PlugInPolicy string PlugInPolicyAllowWithSecurityRestrictions" "$plist_str"
	/usr/libexec/PlistBuddy -c "add $struct_str:3:PlugInRunUnsandboxed bool false" "$plist_str"

	/usr/libexec/PlistBuddy -c "add $struct_str: dict" "$plist_str"   
	/usr/libexec/PlistBuddy -c "add $struct_str:4:PlugInHostname string statistiques.projet-voltaire.fr" "$plist_str"
	/usr/libexec/PlistBuddy -c "add $struct_str:4:PlugInLastVisitedDate date $date_plb" "$plist_str"
	/usr/libexec/PlistBuddy -c "add $struct_str:4:PlugInPageURL string \"http://statistiques.projet-voltaire.fr/\"" "$plist_str"
	/usr/libexec/PlistBuddy -c "add $struct_str:4:PlugInPolicy string PlugInPolicyAllowWithSecurityRestrictions" "$plist_str"
	/usr/libexec/PlistBuddy -c "add $struct_str:4:PlugInRunUnsandboxed bool false" "$plist_str"
done

/usr/libexec/PlistBuddy -c "set :PlugInInfo:com.oracle.java.JavaAppletPlugin:plugInCurrentState true" "$plist_str"
/usr/libexec/PlistBuddy -c "set :PlugInInfo:com.macromedia.Flash\ Player.plugin:plugInCurrentState true" "$plist_str"

# Flush Preferences cache
killall cfprefsd

