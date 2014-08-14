#!/bin/sh

BACKUPDST=${DS_REPOSITORY_PATH}/rbackup/
BACKUPFOLDER=$BACKUPDST${DS_HOSTNAME}


#######################
###### EDIT THIS ######
#######################

# change 'OSX' by your system volume name, (Apple Default : 'Macintosh HD')
VOLSYSNAME='OSX'

# Add files and/or folders to exclude them (Leave "" )
EXCLUDE=( "'*.log'" "'*Caches*'" )

##########################################
###### DO NOT EDIT UNDER THAT LINE #######
##########################################

# Create temporary file to list exclude items
for excludeitems in "${EXCLUDE[@]}"; do
	echo "$excludeitems" >> /tmp/usrbakexcludelist
done

# Create rBackup in the DeployStudio repository
[ ! -d $BACKUPDST ] && { mkdir $BACKUPDST; chmod -R 750 $BACKUPDST; sleep 5; echo "rBackup Folder created"; }

/usr/bin/rsync -rlptDzHhblP --backup-dir=OldBackup --exclude-from /tmp/usrbakexcludelist /Volumes/"$VOLSYSNAME"/Users/ $BACKUPFOLDER

[ -d $BACKUPFOLDER ] && echo "All seems good, the backup folder was created." & exit 0
[ -d $BACKUPFOLDER ] || echo "RuntimeAbortWorkflow: WARNING ! Can't found the backup folder." & exit 1

# Delete temporary file
rm /tmp/usrbakexcludelist