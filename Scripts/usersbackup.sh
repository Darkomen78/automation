#!/bin/sh

# Users folder backup script for DeployStudio
# Version 1.1b by Sylvain La Gravière
# Twitter : @darkomen78
# Mail : darkomen@me.com

BACKUPDST=${DS_REPOSITORY_PATH}/rbackup/
BACKUPFOLDER=$BACKUPDST${DS_HOSTNAME}

if [[ -z "${DS_HOSTNAME}" ]]; then 
BACKUPFOLDER=$BACKUPDST${DS_SERIAL_NUMBER}
fi

#############################
### Edit that if you want ###
#############################

# Short name of the local admin account to exclude from backup
ADMUSR=admin

# Add file or folder pattern to eclude of the save, first line for data in /Users/*folders/files*, next line for local account : shortname*
BAKEXCLUDE=( "*Caches*" "*Trash*" )
USREXCLUDE=( "_*" "$ADMUSR*" "daemon*" "nobody*" "root*" )

############################################
### Don't touch anything under that line ###
############################################


# Determine working directory
POPUP=`dirname "$0"`/cocoaDialog.app/Contents/MacOS/cocoaDialog
# Options for cocoaDialog
RUNMODE="dropdown"
TITLE="Sauvegarde du dossier Utilisateurs"
TEXT="Selectionner votre volume de démarrage :"
OTHEROPTS="--float --string-output --height 150 --width 400"
ITEMS=( /Volumes/*/ )
ICON="home"

#Do the dialog, get the result and strip the Ok button code
RESPONSE=`$POPUP $RUNMODE --button1 "Ok" --button2 "Annuler" $OTHEROPTS  --icon $ICON --title "${TITLE}" --text "${TEXT}" --items "${ITEMS[@]}"`
if [[ $RESPONSE == Annuler* ]]; then
	echo "Backup canceled"
	exit 0
fi
RESPONSE=`echo $RESPONSE | sed 's/Ok //g'`

# Create a temporary file to exclude items
for bakexcludeitems in "${BAKEXCLUDE[@]}"; do
	echo "$bakexcludeitems" >> /tmp/bakexcludelist
done

# Create a temporary file to exclude users
for usrexcludeitems in "${USREXCLUDE[@]}"; do
	echo "$usrexcludeitems" >> /tmp/usrexcludelist
done

# Remove local admin folder
rm -Rf "$RESPONSE"/Users/"$ADMUSR"

# Create rBackup in the DeployStudio repository
[ ! -d $BACKUPFOLDER/Localnode ] && { mkdir -p -m 770 "$BACKUPFOLDER/Localnode"; echo "Backup Folder created"; sleep 2; }

if [ -d $BACKUPFOLDER ]; then
echo "All seems good, the backup folder was created."
else
echo "RuntimeAbortWorkflow: WARNING ! I can't create the backup folder."
exit 1
fi

# Copy dslocal users node
/usr/bin/rsync -rlpPvtDhHblW --inplace --exclude-from=/tmp/usrexcludelist "$RESPONSE"/var/db/dslocal/nodes/Default/users/* $BACKUPFOLDER/Localnode/
for locanodeuser in $BACKUPFOLDER/Localnode/*
do
echo "$localnodeuser local node copied"
done

# Copy user home folder
/usr/bin/rsync -rlpPvtDhHblW --inplace --backup-dir=OldBackup --exclude-from=/tmp/bakexcludelist "$RESPONSE"/Users $BACKUPFOLDER | `dirname "$0"`/rsync-progress.sh
for localdatauser in $BACKUPFOLDER/Users/*
do
echo "$localdatauser data copied"
done

# Remove temporary files
rm /tmp/bakexcludelist
rm /tmp/usrexcludelist

exit 0