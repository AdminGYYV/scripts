#!/bin/bash

###############################################
## Script du gymnase du Bugon
## modifié pour l gymnase d'Yverdon
 
############################################### 
# pour debug
log_file="/dev/stdout"
#log_file=~/Desktop/test.txt
now=$(date +"%T")

######################################################################
# délai (en jour) pour effacer un élément de la poubelle d'OpenBoard
delai_limite="15"
 

######################################################################
# efface les dossiers à la poubelle et les dossiers vides d'OpenBoard
nettoye_OB ()
{
	echo "" >> $log_file
	echo ${OB_Doc} >> $log_file
    if [ -d "${OB_Doc}" ]
    then
      OB_metadata="${OB_Doc}/metadata.rdf"
      echo ${OB_metadata} >> $log_file
      # teste si le document est dans la poubelle de OpenBoard
      if grep -q "<dc:type>_Trash" "${OB_metadata}"
      then 
		echo ${OB_Doc}" est dans la poubelle" >> $log_file
		date_limit=$(date -v-"$delai_limite"d "+%Y-%m-%d")
		date_trash=$(grep "<ub:updated-at" "${OB_metadata}" | cut -c 24-33)
		echo "date limite             "$date_limit >> $log_file
		echo "date mise à la poubelle "$date_trash >> $log_file
      	# teste si le document est dans la poubelle de OpenBoard depuis assez longtemps
		if [[ "$date_limit" > "$date_trash" ]] ;
      	then 
			echo ${OB_Doc}" est depuis assez longtemps dans la poubelle, je l'efface" >> $log_file
			echo "$now : $0    "${OB_Doc}" est depuis assez longtemps dans la poubelle, je l'efface" >> $log_file

     		rm -rv "$OB_Doc"
		fi
      # teste si le document est vide (date creation = date de dernière modif)		
      else	
      	date_modif=$(grep "<ub:updated-at" "${OB_metadata}" | cut -c 24-42)
      	date_crea=$(grep "<dc:date>" "${OB_metadata}" | cut -c 18-36)
		echo "date de creation     "${date_crea} >> $log_file
		echo "$now : $0     "" date de modification "${date_modif} >> $log_file
		if [ "${date_crea}" == "${date_modif}" ]
      	then 
			echo ${OB_Doc}" est vide, je l'efface" >> $log_file
			echo ${OB_Doc}" est vide, je l'efface" >> $log_file

     		rm -rv "$OB_Doc"
		fi
      fi
    fi
}

# parcourir tous les dossiers de  ~/Library/ApplicationSupport/OpenBoard/document/
for OB_Doc in $HOME/Library/Application\ Support/OpenBoard/document/*
do
    nettoye_OB
done

# parcourir tous les dossiers de  ~/Library/ApplicationSupport/OpenBoard/document/
OB_dist_Folder=$1"OpenBoard/document/*"
echo "$now : $0   OB_dist_Folder   "$OB_dist_Folder >> $log_file
for OB_Doc in $OB_dist_Folder
do
    nettoye_OB
done

