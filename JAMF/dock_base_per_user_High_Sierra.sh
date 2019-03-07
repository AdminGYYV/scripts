#!/bin/bash

# Version High Sierra
#
# Recognises maitres based on the keyword maitre in the filepath
#
# Customized accounts : maitres, chocolat & ucl 



# ***** Exclude Local Student Accounts : Set up through the User Template *****
    
if [[ "$LoggedInUserHome" != *"UsersTmp"* || "$LoggedInUserHome" == *"eleve"* ]]
then


	# ***** If Dockutil not installed *****

	if [ -e /usr/local/bin/dockutil ]
	then


    	Version="4.2"
    
    	echo "Setting dock v."$Version

    	LoggedInUser=$3
    	LoggedInUserHome=$(eval echo ~$LoggedInUser)

    	echo "Logged in user is $LoggedInUser" 
    	echo "Logged in user's home $LoggedInUserHome"
    
    	dockutilVersion=sudo /usr/local/bin/dockutil --version echo "dockutil version: $dockutilVersion"

		
        # ***** New script version *****
        
    	if [ -f $LoggedInUserHome/Library/Preferences/com.gyyv.docksetup.$Version.plist ]  
    
    	then
    
        	echo "Dock already initialized."
        
        	# ***** REFRESH MAITRES *****
        	
            if [[ "$LoggedInUserHome" == *"fima"* || "$LoggedInUserHome" == *"TeachersTmp"* ]]
        	then
        
            	echo "Checking for specific applications."
            
            	DOCK_CHANGED=0
        
            	# echo "Adding RemoteDesktop..."
            	RES= grep -c -m 1 RemoteDesktop ~/Library/Preferences/com.apple.dock.plist
            	if [ -e "/Applications/Remote Desktop.app" ] 
            	then
                	if [ ! $RES ]
                	then
                    	/usr/local/bin/dockutil --add /Applications/Remote\ Desktop.app --position 1 --no-restart $LoggedInUserHome
                    	DOCK_CHANGED=1
                	fi
            	else 
                	if [ $RES=1 ]
                	then
                    	/usr/local/bin/dockutil --remove 'Remote Desktop' --no-restart $LoggedInUserHome
                    	DOCK_CHANGED=1
                	fi
            	fi  
            
                # echo "Adding AirPlay..."
                RES= grep -c -m 1 AirPlay ~/Library/Preferences/com.apple.dock.plist
                if [ -e "/Applications/AirPlay.app" ] 
                then
                    if [ ! $RES ]
                    then
                        /usr/local/bin/dockutil --add /Applications/AirPlay.app --position 1 --no-restart $LoggedInUserHome
                        DOCK_CHANGED=1
                    fi
                else 
                    if [ $RES=1 ]
                    then
                        /usr/local/bin/dockutil --remove 'AirPlay' --no-restart $LoggedInUserHome
                        DOCK_CHANGED=1
                    fi
                fi
        
                # echo "Adding OpenBoard..."
                if [ -e "/Applications/OpenBoard.app" ] 
                then
                    RES= grep -c -m 1 OpenBoard ~/Library/Preferences/com.apple.dock.plist
                    if [ ! $RES ]
                    then
                        /usr/local/bin/dockutil --add /Applications/OpenBoard.app --position 1 --no-restart $LoggedInUserHome
                        DOCK_CHANGED=1
                    fi
                else 
                    if [ $RES=1 ]
                    then
                        /usr/local/bin/dockutil --remove 'OpenBoard' --no-restart $LoggedInUserHome
                        DOCK_CHANGED=1
                    fi
                fi
            
                # echo "Adding DisplayMenu..."
                if [ -e "/Applications/Display Menu.app" ] 
                then
                    RES= grep -c -m 1 DisplayMenu ~/Library/Preferences/com.apple.dock.plist
                    if [ ! $RES ]
                    then
                        /usr/local/bin/dockutil --add /Applications/Display\ Menu.app --position 1 --no-restart $LoggedInUserHome
                        DOCK_CHANGED=1
                    fi
                else 
                    if [ $RES=1 ]
                    then
                        /usr/local/bin/dockutil --remove 'Display Menu' --no-restart $LoggedInUserHome
                        DOCK_CHANGED=1
                    fi
                fi

        	fi
    
    	else
    
        	DOCK_CHANGED=1
              

            if [[ "$LoggedInUserHome" == *"fima"* || "$LoggedInUserHome" == *"TeachersTmp"* ]]
            then

				# *********** INIT MAITRES *********** 
                
                echo "OD maitres : Removing Apple dock items"

                # echo "Removing Siri..."
                /usr/local/bin/dockutil --remove 'com.apple.siri' --no-restart $LoggedInUserHome
                /usr/local/bin/dockutil --remove 'com.apple.Siri' --no-restart $LoggedInUserHome
                /usr/local/bin/dockutil --remove 'com.apple.siri.launcher' --no-restart $LoggedInUserHome
                # echo "Removing Launchpad..."
                /usr/local/bin/dockutil --remove 'com.apple.launchpad.launcher' --no-restart $LoggedInUserHome
                # echo "Removing Safari..."
                #/usr/local/bin/dockutil --remove 'Safari' --no-restart $LoggedInUserHome
                #/usr/local/bin/dockutil --remove 'com.apple.Safari' --no-restart $LoggedInUserHome
                # echo "Removing Mail..."
                /usr/local/bin/dockutil --remove 'com.apple.mail' --no-restart $LoggedInUserHome
                # echo "Removing Contacts..."
                /usr/local/bin/dockutil --remove 'com.apple.AddressBook' --no-restart $LoggedInUserHome
                # echo "Removing Calendar..."
                /usr/local/bin/dockutil --remove 'com.apple.iCal' --no-restart $LoggedInUserHome
                # echo "Removing Notes..."
                /usr/local/bin/dockutil --remove 'com.apple.Notes' --no-restart $LoggedInUserHome
                # echo "Removing Reminders..."
                /usr/local/bin/dockutil --remove 'com.apple.reminders' --no-restart $LoggedInUserHome
                # echo "Removing Maps..."
                /usr/local/bin/dockutil --remove 'com.apple.Maps' --no-restart $LoggedInUserHome
                # echo "Removing Photos..."
                /usr/local/bin/dockutil --remove 'com.apple.Photos' --no-restart $LoggedInUserHome
                # echo "Removing Messages..."
                /usr/local/bin/dockutil --remove 'com.apple.iChat' --no-restart $LoggedInUserHome
                # echo "Removing FaceTime..."
                /usr/local/bin/dockutil --remove 'com.apple.FaceTime' --no-restart $LoggedInUserHome
                # echo "Removing Pages..."
                /usr/local/bin/dockutil --remove 'com.apple.iWork.Pages' --no-restart $LoggedInUserHome
                # echo "Removing Numbers..."
                /usr/local/bin/dockutil --remove 'com.apple.iWork.Numbers' --no-restart $LoggedInUserHome
                # echo "Removing Keynote..."
                #/usr/local/bin/dockutil --remove 'Keynote' --no-restart $LoggedInUserHome
                #/usr/local/bin/dockutil --remove 'com.apple.iWork.Keynote' --no-restart $LoggedInUserHome
                # echo "Removing iBooks..."
                /usr/local/bin/dockutil --remove 'com.apple.iBooksX' --no-restart  $LoggedInUserHome
                # echo "Removing  AppStore..."
                /usr/local/bin/dockutil --remove 'com.apple.appstore' --no-restart  $LoggedInUserHome
                # echo "Removing  SystemPreferences..."
                /usr/local/bin/dockutil --remove 'com.apple.systempreferences' --no-restart  $LoggedInUserHome
                /usr/local/bin/dockutil --remove 'org.videolan.vlc' --no-restart  $LoggedInUserHome
                /usr/local/bin/dockutil --remove 'VLC' --no-restart  $LoggedInUserHome
                /usr/local/bin/dockutil --remove 'com.apple.DVDPlayer' --no-restart  $LoggedInUserHome
                /usr/local/bin/dockutil --remove 'GYYV_connecter_dossier' --no-restart  $LoggedInUserHome
                /usr/local/bin/dockutil --remove 'com.druide.Antidote' --no-restart  $LoggedInUserHome

            else
            
                
                # ***** Portables TE *****
    
				echo "Local non-student accounts : Removing all dock items"

                # echo "Removing All..."
                /usr/local/bin/dockutil --remove all --no-restart  $LoggedInUserHome

            fi 

        
        	echo "ADDING dock items..."
            

            # *********** MAITRES / UCL ***********

            if [[ "$LoggedInUserHome" == *"fima"* || "$LoggedInUserHome" == *"ucl"* || "$LoggedInUserHome" == *"TeachersTmp"* ]]
            then

                echo "Maitre : adding Maitre dock items"

                # echo "Adding RemoteDesktop..."
                RES= grep -c -m 1 RemoteDesktop ~/Library/Preferences/com.apple.dock.plist
                if [ -e "/Applications/Remote Desktop.app" ] 
                then
                    if [ ! $RES ]
                    then
                        /usr/local/bin/dockutil --add /Applications/Remote\ Desktop.app --position 1 --no-restart $LoggedInUserHome
                    fi
                else 
                    if [ $RES=1 ]
                    then
                        /usr/local/bin/dockutil --remove 'Remote Desktop' --no-restart $LoggedInUserHome
                    fi
                fi  

                # echo "Adding AirPlay..."
                RES= grep -c -m 1 AirPlay ~/Library/Preferences/com.apple.dock.plist
                if [ -e "/Applications/AirPlay.app" ] 
                then
                    if [ ! $RES ]
                    then
                        /usr/local/bin/dockutil --add /Applications/AirPlay.app --position 1 --no-restart $LoggedInUserHome
                    fi
                else 
                    if [ $RES=1 ]
                    then
                        /usr/local/bin/dockutil --remove 'AirPlay' --no-restart $LoggedInUserHome
                    fi
                fi

                # echo "Adding OpenBoard..."
                if [ -e "/Applications/OpenBoard.app" ] 
                then
                    RES= grep -c -m 1 OpenBoard ~/Library/Preferences/com.apple.dock.plist
                    if [ ! $RES ]
                    then
                        echo "OpenBoard not found"
                        echo $RES
                        /usr/local/bin/dockutil --add /Applications/OpenBoard.app --position 1 --no-restart $LoggedInUserHome
                    fi
                else 
                    if [ $RES=1 ]
                    then
                        /usr/local/bin/dockutil --remove 'OpenBoard' --position 1 --no-restart $LoggedInUserHome
                    fi
                fi

                # echo "Adding Display Menu..."
                if [ -e "/Applications/Display Menu.app" ] 
                then
                    RES= grep -c -m 1 DisplayMenu ~/Library/Preferences/com.apple.dock.plist
                    if [ ! $RES ]
                    then
                        /usr/local/bin/dockutil --add /Applications/Display\ Menu.app --position 1 --no-restart $LoggedInUserHome
                    fi
                else 
                    if [ $RES=1 ]
                    then
                        /usr/local/bin/dockutil --remove 'Display Menu' --no-restart $LoggedInUserHome
                    fi
                fi

            fi

        
            # *********** chocolat ***********

            if [[ "$LoggedInUserHome" == *"chocolat"* ]]
            then   

                echo "Chocolat : adding Chocolat dock items" 

                # echo "Adding DisplayMenu..."
                if [ -e "/Applications/Display Menu.app" ] 
                then
                    RES= grep -c -m 1 DisplayMenu ~/Library/Preferences/com.apple.dock.plist
                    if [ ! $RES ]
                    then
                        /usr/local/bin/dockutil --add /Applications/Display\ Menu.app --no-restart $LoggedInUserHome
                    fi
                else 
                    if [ $RES=1 ]
                    then
                        /usr/local/bin/dockutil --remove 'Display Menu' --no-restart $LoggedInUserHome
                    fi
                fi            

                # echo "Adding RemoteDesktop..."
                RES= grep -c -m 1 RemoteDesktop ~/Library/Preferences/com.apple.dock.plist
                if [ -e "/Applications/Remote Desktop.app" ] 
                then
                    if [ ! $RES ]
                    then
                        /usr/local/bin/dockutil --add /Applications/Remote\ Desktop.app --no-restart $LoggedInUserHome
                    fi
                else 
                    if [ $RES=1 ]
                    then
                        /usr/local/bin/dockutil --remove 'Remote Desktop' --no-restart $LoggedInUserHome
                    fi
                fi  

                # echo "Adding Terminal..."
                if [ -e "/Applications/Utilities/Terminal.app" ] 
                then
                    RES= grep -c -m 1 Terminal ~/Library/Preferences/com.apple.dock.plist
                    if [ ! $RES ]
                    then
                        /usr/local/bin/dockutil --add /Applications/Utilities/Terminal.app --no-restart $LoggedInUserHome
                    fi
                else 
                    if [ $RES=1 ]
                    then
                        /usr/local/bin/dockutil --remove 'Terminal' --no-restart $LoggedInUserHome
                    fi
                fi 

                # echo "Adding Console..."
                if [ -e "/Applications/Utilities/Console.app" ] 
                then
                    RES= grep -c -m 1 Console ~/Library/Preferences/com.apple.dock.plist
                    if [ ! $RES ]
                    then
                        /usr/local/bin/dockutil --add /Applications/Utilities/Console.app --no-restart $LoggedInUserHome
                    fi
                else 
                    if [ $RES=1 ]
                    then
                        /usr/local/bin/dockutil --remove 'Console' --no-restart $LoggedInUserHome
                    fi
                fi     

                # echo "Adding OnyX..."
                if [ -e "/Applications/Utilities/OnyX.app" ] 
                then
                    RES= grep -c -m 1 OnyX ~/Library/Preferences/com.apple.dock.plist
                    if [ ! $RES ]
                    then
                        /usr/local/bin/dockutil --add /Applications/Utilities/OnyX.app --no-restart $LoggedInUserHome
                    fi
                else 
                    if [ $RES=1 ]
                    then
                        /usr/local/bin/dockutil --remove 'OnyX' --no-restart $LoggedInUserHome
                    fi
                fi    

                # echo "Adding BBEdit..."
                if [ -e "/Applications/_Informatique/BBEdit.app" ] 
                then
                    RES= grep -c -m 1 BBEdit ~/Library/Preferences/com.apple.dock.plist
                    if [ ! $RES ]
                    then
                        /usr/local/bin/dockutil --add /Applications/_Informatique/BBEdit.app --position 8 --no-restart $LoggedInUserHome
                    fi
                else 
                    if [ $RES=1 ]
                    then
                        /usr/local/bin/dockutil --remove 'BBEdit' --no-restart $LoggedInUserHome
                    fi
                fi 

                 # echo "Adding Utilitaire d'annuaire..."
                if [ -e "/System/Library/CoreServices/Applications/Directory Utility.app" ] 
                then
                    RES= grep -c -m 1 Directory ~/Library/Preferences/com.apple.dock.plist
                    if [ ! $RES ]
                    then
                        /usr/local/bin/dockutil --add /System/Library/CoreServices/Applications/Directory\ Utility.app --position 6 --no-restart $LoggedInUserHome
                    fi
                else 
                    if [ $RES=1 ]
                    then
                        /usr/local/bin/dockutil --remove 'Directory Utility' --no-restart $LoggedInUserHome
                    fi
                fi   

                # echo "Adding Munki..."
                if [ -e "/Applications/Managed Software Center.app" ] 
                then
                    RES= grep -c -m 1 Managed ~/Library/Preferences/com.apple.dock.plist
                    if [ ! $RES ]
                    then
                        /usr/local/bin/dockutil --add /Applications/Managed\ Software\ Center.app --position 7 --no-restart $LoggedInUserHome
                    fi
                else 
                    if [ $RES=1 ]
                    then
                        /usr/local/bin/dockutil --remove 'Managed Software Center' --no-restart $LoggedInUserHome
                    fi
                fi         

            fi

   
        	# *********** PORTABLE TE ***********
 
        	if [[ "$LoggedInUserHome" == *"eleve"* ]]
            then
            
              # echo "Adding Display Menu..."
              if [ -e "/Applications/Display Menu.app" ] 
              then
              	RES= grep -c -m 1 DisplayMenu ~/Library/Preferences/com.apple.dock.plist
                if [ ! $RES ]
                then
                	/usr/local/bin/dockutil --add /Applications/Display\ Menu.app --position 1 --no-restart $LoggedInUserHome
                fi
              fi
              
			  RES= grep -c -m 1 Safari  ~/Library/Preferences/com.apple.dock.plist
              if [ ! $RES ]
              then
                  /usr/local/bin/dockutil --add /Applications/Safari.app --after Display\ Menu --no-restart $LoggedInUserHome
 			  fi	
 
              # echo "Adding PowerPoint..."
              RES= grep -c -m 1 Powerpoint ~/Library/Preferences/com.apple.dock.plist
              if [ ! $RES ]
              then 
                  /usr/local/bin/dockutil --add /Applications/Microsoft\ PowerPoint.app --after Safari --no-restart $LoggedInUserHome
              fi
 
   
              # echo "Adding Keynote..."
              RES= grep -c -m 1 Keynote ~/Library/Preferences/com.apple.dock.plist
              if [ ! $RES ]
              then 
                  /usr/local/bin/dockutil --add /Applications/Keynote.app --after -no-restart $LoggedInUserHome
              fi   
   
              # echo "Adding System Preferences..."
              /usr/local/bin/dockutil --add /Applications/System\ Preferences.app --no-restart $LoggedInUserHome

            
            else 
            
              
              # *********** BROWSERS & BUREAUTIQUE ***********
 
        
              # echo "Adding Safari..."
              RES= grep -c -m 1 Safari  ~/Library/Preferences/com.apple.dock.plist
              if [ ! $RES ]
              then
                  if [[ "$LoggedInUserHome" == *"fima"* || "$LoggedInUserHome" == *"ucl"* || "$LoggedInUserHome" == *"TeachersTmp"* ]]
                  then
                      /usr/local/bin/dockutil --add /Applications/Safari.app --after Display\ Menu --no-restart $LoggedInUserHome
                  else
                      if [[ "$LoggedInUser" != "chocolat" ]]
                      then
                          /usr/local/bin/dockutil --add /Applications/Safari.app --position 1 --no-restart $LoggedInUserHome
                      fi
                  fi
              fi


              # echo "Adding Keynote..."
              RES= grep -c -m 1 Keynote ~/Library/Preferences/com.apple.dock.plist
              if [ ! $RES ]
              then 
                  if [[ "$LoggedInUser" != "chocolat" ]]
                  then
                      /usr/local/bin/dockutil --add /Applications/Keynote.app --after Safari --no-restart $LoggedInUserHome
                  else
                      /usr/local/bin/dockutil --add /Applications/Keynote.app -no-restart $LoggedInUserHome
                  fi
              fi


              if [[ "$LoggedInUser" != "chocolat" ]]
              then

                  # echo "Adding Firefox..."
                  RES= grep -c -m 1 FireFox ~/Library/Preferences/com.apple.dock.plist
                  if [ ! $RES ]
                  then
                      /usr/local/bin/dockutil --add /Applications/FireFox.app --after Safari --no-restart $LoggedInUserHome
                  fi


                  # echo "Adding Google Chrome..."
                  RES= grep -c -m 1 Chrome ~/Library/Preferences/com.apple.dock.plist
                  if [ ! $RES ]
                  then
                      /usr/local/bin/dockutil --add "/Applications/Google Chrome.app" --after FireFox --no-restart $LoggedInUserHome
                  fi
              fi    


              # echo "Adding PowerPoint..."
              RES= grep -c -m 1 Powerpoint ~/Library/Preferences/com.apple.dock.plist
              if [ ! $RES ]
              then 
                  /usr/local/bin/dockutil --add /Applications/Microsoft\ PowerPoint.app --before Keynote --no-restart $LoggedInUserHome
              fi

              if [[ "$LoggedInUser" != "chocolat" ]]
              then

                  # echo "Adding Excel..."
                  RES= grep -c -m 1 Excel ~/Library/Preferences/com.apple.dock.plist
                  if [ ! $RES ]
                  then
                      /usr/local/bin/dockutil --add /Applications/Microsoft\ Excel.app --before Microsoft\ PowerPoint --no-restart $LoggedInUserHome
                  fi

                  # echo "Adding Word..."
                  RES= grep -c -m 1 Word ~/Library/Preferences/com.apple.dock.plist
                  if [ ! $RES ]
                  then
                      /usr/local/bin/dockutil --add /Applications/Microsoft\ Word.app --before Microsoft\ Excel --no-restart $LoggedInUserHome
                  fi


                  # echo "Adding LibreOffice..."
                  RES= grep -c -m 1 LibreOffice ~/Library/Preferences/com.apple.dock.plist
                  if [ ! $RES ]
                  then
                      /usr/local/bin/dockutil --add /Applications/LibreOffice.app --before Microsoft\ Word --no-restart $LoggedInUserHome
                  fi    
              fi



              # *********** MULTIMEDIA & ONE-OFFS ***********   

              if [[ "$LoggedInUser" != "chocolat" ]]
              then

                  # echo "Adding VLC..."
                  RES= grep -c -m 1 VLC ~/Library/Preferences/com.apple.dock.plist
                  if [ ! $RES ]
                  then 
                      /usr/local/bin/dockutil --add "/Applications/VLC.app" --after com.apple.keynote --no-restart $LoggedInUserHome
                  fi

                  # echo "DVD Player..."
                  RES= grep -c -m 1 DVD ~/Library/Preferences/com.apple.dock.plist
                  if [ ! $RES ]
                  then 
                      /usr/local/bin/dockutil --add /Applications/DVD\ Player.app --after VLC --no-restart $LoggedInUserHome
                  fi

                  # echo "Adding Antidote..."
                  RES= grep -c -m 1 Antidote ~/Library/Preferences/com.apple.dock.plist
                  if [ -e "/Applications/Antidote 9.app" ] 
                  then
                      if [ ! $RES ]
                      then
                          /usr/local/bin/dockutil --add /Applications/Antidote\ 9.app --after Display\ Menu --no-restart $LoggedInUserHome
                      fi
                  else 
                      if [ $RES=1 ]
                      then
                          /usr/local/bin/dockutil --remove 'Antidote 9' --no-restart $LoggedInUserHome
                      fi
                  fi

              fi

              # echo "Windows/..."     
              RES= grep -c -m 1 Windows ~/Library/Preferences/com.apple.dock.plist            
              if [ -e "/Applications/Windows 7.app" ] 
              then
                  if [ ! $RES ]
                  then
                      /usr/local/bin/dockutil --add /Applications/Windows\ 7.app --position 1 --no-restart $LoggedInUserHome
                  fi
              else 
                  if [ $RES=1 ]
                  then
                      /usr/local/bin/dockutil --remove 'Windows 7' --no-restart $LoggedInUserHome
                  fi
              fi


              # echo "Adding System Preferences..."
              /usr/local/bin/dockutil --add /Applications/System\ Preferences.app --no-restart $LoggedInUserHome


              if [[ "$LoggedInUserHome" == *"fima"* || "$LoggedInUserHome" == *"TeachersTmp"* ]]
              then
                  /usr/local/bin/dockutil --add /Applications/GYYV_connecter_dossier.app --no-restart $LoggedInUserHome

              fi


              # *********** ON THE RIGHT ***********   

              if [[ "$LoggedInUser" != "chocolat" ]]
              then
                  # echo "Adding Downloads..."
                  /usr/local/bin/dockutil --add '~/Downloads' --no-restart $LoggedInUserHome
              fi

              if [[ "$LoggedInUser" != "chocolat" ]]
              then
                  # echo "Adding Home..."
                  /usr/local/bin/dockutil --add '~/' --no-restart $LoggedInUserHome
              fi

              # echo "Adding Applications..."
              /usr/local/bin/dockutil --add '/Applications' --no-restart $LoggedInUserHome

              # echo "Adding GYYV url..."
              /usr/local/bin/dockutil --add https://www.gyyv.vd.ch --label 'gyyv.vd.ch' --no-restart $LoggedInUserHome

        	fi
        
        
        	# ***** VERSION CONTROL *****
        
        	#remove previous flags
        	rm $LoggedInUserHome/Library/Preferences/com.gyyv.docksetup.*
    
        	#set flag
        	touch $LoggedInUserHome/Library/Preferences/com.gyyv.docksetup.$Version.plist
    
    	fi
    
    
	else 

    	echo "Dockutil not installed, skipping initial dock setup..."

	fi

fi


# ***** SHOW NEW DOCK IF CHANGED *****

if [ $DOCK_CHANGED ]
then
    killall Dock
    echo 'Dock restarted...'   
else
    echo 'Dock has not changed since previous login.'   
fi


exit 0



