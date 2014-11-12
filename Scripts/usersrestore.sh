#!/bin/sh

# Users folder restore script for DeployStudio
# Version 1.1 by Sylvain La Gravière
# Twitter : @darkomen78
# Mail : darkomen@me.com

BACKUPDST=${DS_REPOSITORY_PATH}/rbackup/
BACKUPFOLDER=$BACKUPDST${DS_HOSTNAME}
VOLSYSNAME=${DS_LAST_RESTORED_VOLUME}

# 
if [[ -z "${DS_HOSTNAME}" ]]; then 
BACKUPFOLDER=$BACKUPDST${DS_SERIAL_NUMBER}
fi

if [ -d $BACKUPFOLDER ]; then
# Restore /Users from the rbackup folder and add users information in local database
/usr/bin/rsync -rlpPvtDhHblW --inplace $BACKUPFOLDER/Localnode/* /Volumes/"$VOLSYSNAME"/var/db/dslocal/nodes/Default/users/
/usr/bin/rsync -rlpPvtDhHblW --inplace $BACKUPFOLDER/Users/* /Volumes/"$VOLSYSNAME"/Users/ | `dirname "$0"`/rsync-progress.sh
# get UID from plist
for plistvar in $BACKUPFOLDER/Localnode/*
do
# Get local UID and ShortName user from backup plist
namevar=(`/usr/libexec/PlistBuddy -c "Print name" $plistvar | awk NR==2`)
uidvar=(`/usr/libexec/PlistBuddy -c "Print uid" $plistvar | awk NR==2`)
# Change Owner and Rights on home folder
chown -R "$uidvar":admin /Volumes/"$VOLSYSNAME"/Users/"$namevar"
chmod -R 755 /Volumes/"$VOLSYSNAME"/Users/"$namevar"
done
echo "All seems good, the backup was restored."
else
echo "ERROR. Can't found the backup folder."
fi
exit 0