#!/bin/bash
#
## Développé pour le Gymnase du Bugnon
## avril septembre 2018
#
## Modifié pour le gymnase d'Yverdon
## décembre 2018
#
## Pour des utilisateurs "mobile" qui ouvrent une session locale
## et qui ont un dossier réseau sur un serveur smb
## Script lancé par des LaunchAgents
## Copie des dossiers et/ou fichiers du dossier réseau dans le dossier local au login 
## et l'inverse s'il y a du changement

######################################################################
## Variables et fichiers pour que le script fonctionne :
######################################################################

### Sur le poste, en dehors du homedir
# $LOCAL_REPO
#	|- sync/
#		|- aliases/				($aliases_f) dossier contenant tous les alias utiliser pour le processus de synchro
#			|- 
#		|- synchro_data.csv		($synchro_data) info sur les données à copier
#		|- aff_message_attente.sh
#		|- aff_mess_reseau_synchro
#		|- aff_mess_reseau_login
#		|- nettoye_openboard.sh
#		|- synchro_totale.sh	le fichier courant
#	|- fima_mount_script.py		($SCRIPT_MOUNT_MAITRES) pour monter les volumes réseau des maîtres
#	|- fs_mount_script.py		($SCRIPT_MOUNT_ELEVES) pour monter les volumes réseau des élèves

### Dans le homedir distant
#	$dist_user_folder
#		|- sync					($dist_synchro) dossier contenant toutes les données à synchroniser
#




# définit le nom du dossier local de la machine cliente où se touvent les scripts et les aliases
LOCAL_REPO="/.gyyv/"
LOCAL_DIR_PATH="$LOCAL_REPO""sync/" 

# définit les scripts pour monter les volumes (écrit python)
SCRIPT_MOUNT_ELEVES="$LOCAL_REPO""fs_mount_script.py"
SCRIPT_MOUNT_MAITRES="$LOCAL_REPO""fima_mount_script.py"

# définit le fichier global qui contient les infos sur les dossiers à copier
synchro_data="$LOCAL_DIR_PATH/synchro_data.csv"


# définit le fichier de $USER qui contient les infos sur les dossiers à copier
# cela permet à certains utilisateurs de synchroniser des éléments supplémentaires
synchro_data_user="$dist_user_folder""/synchro_data.csv"

######################################################################
######################################################################


############################################### 
# pour debug
#log_file="/dev/stdout"
log_file=~/Desktop/test.txt
touch $log_file
now=$(date +"%T")

############################################### 
# test paramètre du script présent?
if [ $# -eq 0 ]
  then
    echo "No arguments supplied" >> $log_file
    exit
fi

############################################### 
# teste si un réseau est connecté, sinon message d'alerte et exit
# adresse du default gateway
gateway=$(route get default | grep gateway | cut -d : -f 2 | tail -c +2)
# teste si gateway n'est pas accessible
if ! ping -q -W 1 -c 1 $gateway > /dev/null; then
	echo "pas de réseau" >> $log_file
	if [ $1 = "login" ]; then
			message="!!! Pas de réseau !!! \n\nVérifiez que le câble réseau est bien branché \nou que le wifi est activé.\n\nPuis quittez votre session et reconnectez-vous!"					
			open /Library/Scripts/a_Scripts/aff_mess_reseau_login.app
	elif [ $1 = "synchro" ]; then
			message="!!! Plus de réseau !!! \n\nVérifiez que le câble réseau est bien branché \nou que le wifi est activé"					
#			osascript -e "display dialog \"$message\" with title \"Attention\" buttons \"OK\" default button \"OK\" " &	 
			open /Library/Scripts/a_Scripts/aff_mess_reseau_synchro.app
	fi
	echo "$now : $0  $1  "$message >> $log_file
	exit
fi

###########################################################################################
###########################################################################################
#### Définition des variables Bugnon
###########################################################################################
#
################################################ Réglages 
## nom de l'utilisateur avec la première lettre en majuscule
## le nom du dossier réseau est le même que le nom d'utilisateur avec la première lettre en majuscule
#UserMaj=$USER
#UserMaj="$(tr '[:lower:]' '[:upper:]' <<< ${UserMaj:0:1})${UserMaj:1}"
#
#
################################################ 
## Nom des groupes des utilisateurs pour définir le chemin du dossier distant sur le serveur
#GROUPE_ELEVES="Bugnon_Etudiants"
#GROUPE_PROFS="Bugnon_Enseignants"
#
## l'utilisateur est-il membre du groupe "eleves" ?
#		if [[ $(dsmemberutil checkmembership -U $USER -G "$GROUPE_ELEVES") == "user is a member of the group" ]]
#		then
#			GROUPE="HomesEleves"
#		else
#			if [[ $(dsmemberutil checkmembership -U $USER -G "$GROUPE_PROFS") == "user is a member of the group" ]]
#			then
#				GROUPE="HomesMaitres"
#			else
#				echo "utilisateur non AD -> EXIT" >> $log_file
#				exit
#			fi	
#		fi
#
################################################ 
## nom du dossier distant (serveur) de l'utilisateur
#dist_folder_name="$UserMaj""_Reseau"
#
## chemin du dossier distant (serveur) de l'utilisateur
#dist_user_folder="/Volumes/""$dist_folder_name""/"
##echo $dist_folder >> $log_file
#
################################################
## definit le nom du dossier caché contenant les pref de toutes les applications dans le dossier distant
#dist_synchro="$dist_user_folder"".Synchro/"
#
################################################
## definit le nom du dossier des alias à surveiller pour la synchro
## ATTENTION ce dossier doit être en lecture/ecriture pour tous
## et il ne doit pas se trouver dans le dossier utilisateur
#alias_f="/Library/Scripts/a_Scripts/aliases/"
#
#######################################################################
## définit le fichier global qui contient les infos sur les dossiers à copier
#synchro_data="/Library/Scripts/a_Scripts/synchro_data.csv"
#
#######################################################################
## définit le fichier de $USER qui contient les infos sur les dossiers à copier
## cela permet à certains utilisateurs de synchroniser des éléments supplémentaires
#synchro_data_user="$dist_user_folder""/synchro_data.csv"

##########################################################################################
##########################################################################################
### Définition des variables Yverdon
##########################################################################################

############################################### Réglages 

############################################### 
# Nom des groupes des utilisateurs pour définir le chemin du dossier distant sur le serveur
GROUPE_ELEVES="etudiants"
GROUPE_PROFS="maitreslocaux"

# l'utilisateur est-il membre du groupe "eleves" ?
		if [[ $(dsmemberutil checkmembership -U $USER -G "$GROUPE_ELEVES") == "user is a member of the group" ]]
		then
			GROUPE="etudiants"
		else
			if [[ $(dsmemberutil checkmembership -U $USER -G "$GROUPE_PROFS") == "user is a member of the group" ]]
			then
				GROUPE="maitres"
			else
				echo "utilisateur non AD -> EXIT" >> $log_file
				exit
			fi	
		fi

echo "GROUPE : $GROUPE" >> $log_file

############################################### 
# nom du dossier distant (serveur) de l'utilisateur
dist_folder_name="$USER"

# chemin du dossier distant (serveur) de l'utilisateur
dist_user_folder="/Volumes/$dist_folder_name/"
#echo $dist_folder >> $log_file

###############################################
# definit le nom du dossier contenant les pref de toutes les applications dans le dossier distant
dist_synchro="$dist_user_folder""sync/"


###############################################
# definit le nom du dossier des alias à surveiller pour la synchro
# ATTENTION ce dossier doit être en lecture/ecriture pour tous
# et il ne doit pas se trouver dans le dossier utilisateur
alias_f="$LOCAL_DIR_PATH/aliases/"




##########################################################################################
##########################################################################################
### Définition des Fonctions
##########################################################################################


######################################################################
# monte le dossier distant
mount_dist_user_folder ()
{
	# A n'executer que si le dossier distant n'est pas monté automatiquement par le système
	# Cela dépend de la config du serveur de fichier smb	
	if [ $GROUPE = "maitres" ]
	then
		python $SCRIPT_MOUNT_MAITRES
	else
		if [ $GROUPE = "eleves" ]
		then
			python $SCRIPT_MOUNT_ELEVES
		else
			echo "Impossible de monter le homedir distant - groupe inconnu $GROUPE" >> $log_file
		fi
	fi
			
}


######################################################################
# vérifie la présence du dossier distant et le re-monte au cas ou
remount_dist_user_folder ()
{
	if ls $dist_user_folder; then	
		echo  "$dist_user_folder est déjà monté" >> $log_file
		
		else
			############################################### 
			# sinon essaie de le remonter
			mount_dist_user_folder 
			sleep 5
			if ls $dist_user_folder; then	
				echo  "$dist_user_folder a été remonté" >> $log_file
				# sinon afficher un message d'erreur (qui dépend de la config mac et serveur smb)
				else
				message="Problème de connexion avec le dossier  "$dist_folder_name".\n\nVeuillez éjectez le ou les dossiers  --  "$USER"  --  présents sur le bureau. Puis cliquez dans le dock sur : \n          Dossier de départ de "$(id -F)" .\nFinalement, quittez puis relancer votre session"					
				osascript -e "display dialog \"$message\" with title \"Attention\" buttons \"OK\" default button \"OK\" " &
					echo  "$dist_user_folder n'est pas monté, j'arrête" >> $log_file
					exit
			fi
		fi
}

######################################################################
# copie distant->local
copy_to_local ()
{
	###############################################
	# le nom du fichier à lire en premier argument
	csv_file=$1
	
	######################################################################
	# debut de la boucle de copie vers le dossier local
	# lecture de toutes les informations sur les données à synchroniser necessaires dans le fichier csv
	# les infos se trouvent à partir de la 3e ligne
	tail -n +3 $csv_file | while IFS=";" read -r pref_local_watch app_dist_folder app_local_folder app_pref
	do
		
		# crée les alias des fichiers/dossiers à surveiller pour la synchronisation
		index=$(( $index + 1 ))
		app_alias="$alias_f""app""$index"
		pref_to_watch="$HOME""$pref_local_watch"
		ln -s "$pref_to_watch" "$app_alias"
		
		# définition et evt création des dossiers distants et locaux et des données à synchroniser		
		local_folder="$HOME""$app_local_folder"
		local_pref="$local_folder""$app_pref"
		dist_folder="$dist_synchro""$app_dist_folder"
		dist_pref="$dist_folder""$app_pref"
		
		echo "script de synchro pour $pref_local_watch : $now" >> $log_file
		echo "local_folder is     : $local_folder" >> $log_file
		echo "local_pref is: $local_pref" >> $log_file
		echo "dist_folder is  : $dist_folder" >> $log_file
		echo "dist_pref is  : $dist_pref" >> $log_file
				
		# si pas de dossier local, le créer
		if [ ! -d "${local_folder}" ]; then
			mkdir -p "$local_folder"
		fi	
		
		# si pas de dossier distant, le créer
		if [ ! -d "${dist_folder}" ]; then
			mkdir -p $dist_folder
		fi	
		
		# copie du dossier/fichier distant dans le dossier/fichier local
		# option -u pour ne pas effacer un fichier plus récent sur la destination
		echo "ici"
		rsync -av -u "$dist_pref" "$local_pref"
		if [[ $? -gt 0 ]] 
			then
				message="Problème lors de la copie de ""$dist_folder_name""\nvers le dossier local"
				osascript -e "display dialog \"$message\" with title \"Attention\" buttons \"OK\" default button \"OK\" " &
			else
	   			echo "Rsync to local OK" >> $log_file
		fi
	done
	# fin de la boucle	
}

######################################################################
# copie local->distant
copy_to_dist ()
{
	###############################################
	# le nom du fichier à lire en premier argument
	csv_file=$1

	######################################################################
	# debut de la boucle de copie vers le dossier distant
	# lecture de toutes les informations sur les données à synchroniser necessaires dans le fichier csv (séparateur virgule)
	# les infos se trouvent à partir de la 3e ligne
	tail -n +3 $synchro_data | while IFS=";" read -r pref_local_to_watch app_dist_folder app_local_folder app_pref
	do

		# définition des dossiers distants et locaux et des données à synchroniser
		local_pref="$HOME""$app_local_folder""$app_pref"
		dist_pref="$dist_synchro""$app_dist_folder""$app_pref"
			
		echo "" >> $log_file
		echo "script synchro : $now" >> $log_file
		echo "local_pref is       : $local_pref" >> $log_file
		echo "dist_pref is        : $dist_pref" >> $log_file
		echo "$"
		# copie du dossier/fichier local dans le dossier/fichier distant
		# option -u pour ne pas effacer un fichier plus récent sur la destination
		# option --no-p pour éviter des problèmes d'autorisations en copiant sur le dossier SMB (Bug ?)
		rsync -av --no-p -u "$local_pref" "$dist_pref"
		if [[ $? -gt 0 ]] 
			then
				message="Problème lors de la copie du dossier local\nvers ""$dist_folder_name"
				osascript -e "display dialog \"$message\" with title \"Attention\" buttons \"OK\" default button \"OK\" " &
			else
	   			echo "Rsync to distant OK" >> $log_file
		fi
	done
	# fin de la boucle
}


##########################################################################################
##########################################################################################
### Programme principal
##########################################################################################


##########################################################################################
# à executer au login de l'utilisateur , copie distant -> local
if [ $1 = "login" ]; then
	
	###############################################
	# Debug
	echo "" >> $log_file 
	echo "" >> $log_file
	echo "$now : $0  $1" >> $log_file

	###############################################
	# cree un alias du dossier reseau de l'utilisateur dans son dossier Document local
	# ceci n'est pas du tout necessaire pour ce script
	#unlink /Users/$USER/Documents/$dist_folder_name
	#ln -s $dist_user_folder /Users/$USER/Documents
	unlink $HOME/Documents/$dist_folder_name
	ln -s $dist_user_folder $HOME/Documents

	###############################################
	# efface les fichiers et les alias du dossier aliases mais pas les éventuels dossiers
	find $alias_f -type l -d 1 -delete
	find $alias_f -type f -d 1 -delete
	
	############################################### 
	# afficher un message d'attente pendant la copie initiale
	$LOCAL_DIR_PATH/aff_message_attente.sh &

	############################################### 
	# monte le dossier distant et vérifie si c'est fait
	mount_dist_user_folder
	remount_dist_user_folder

	###############################################
	# si pas de dossier .Synchro dans le dossier distant, le créer
	if [ ! -d "${dist_synchro}" ]; then
		mkdir  $dist_synchro
	fi

	###############################################
	# vide la poubelle et les fichiers vides d'OpenBoard (distants et locaux)
	$LOCAL_DIR_PATH/nettoye_openboard.sh $dist_synchro
	
	###############################################
	# initialisation de l'index pour numéroter les alias des dossiers à surveiller
	index=0

	###############################################
	# copie vers le dossier local
	copy_to_local $synchro_data

	###############################################
	# copie vers le dossier local les éléments propres à $USER
	if [ -f $synchro_data_user ]; then 
		copy_to_local $synchro_data_user
	fi

	###############################################
	# finalement, crée un fichier pour débloquer l'execution du script de copie vers le dossier distant
	touch $alias_f/debloque_synchro_$USER


##########################################################################################
# à executer dès qu'une modification a eu lieu , copie local -> distant
elif [ $1 = "synchro" ]; then
	
	###############################################
	# Debug
	echo "" >> $log_file 
	echo "" >> $log_file
	echo "$now : $0  $1" >> $log_file
		
		
	######################################################################
	# si le fichier débloquant n'est pas là, arrêter le script
	if [ ! -f $alias_f/debloque_synchro_$USER ]; then
		echo "" >> $log_file
		echo " Synchro $now : c'est trop tôt , il n'y a pas de fichiet $alias_f/debloque_synchro_$USER" >> $log_file
		exit
	fi	

	############################################### 
	# remonte le dossier distant s'il a été démonté
	remount_dist_user_folder

	######################################################################
	# copie vers le dossier distant
	copy_to_dist $synchro_data
	
	######################################################################
	# copie vers le dossier local les éléments propres à $USER
	if [ -f $synchro_data_user ]; then 
		copy_to_dist $synchro_data_user
	fi

fi