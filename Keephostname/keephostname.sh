#!/bin/bash

LASTRESTVOL=${DS_LAST_RESTORED_VOLUME}
# IT local Folder
ITFOLD="/Applications/Utilities/IT"
# IT Folder in the last restored volume on DeployStudio Runtime
DSITFOLD=/Volumes/$LASTRESTVOL"$ITFOLD"
# hostname value in the DeployStudio Database
DSHOST=${DS_HOSTNAME}
# local domain
DOMAIN=infernobox.lan
# DSNAME=${DS_COMPUTERNAME}

# The user-friendly name for the system.
COMNAME="$(/usr/sbin/scutil --get ComputerName)"
# The local (Bonjour) host name.
LOCALNAME="$(/usr/sbin/scutil --get LocalHostName)"
# The Real Hostname.
SHORTNAME="$(/usr/sbin/scutil --get HostName)"
[ -z "$SHORTNAME" -a "${SHORTNAME+x}" = "x" ] && echo "current hostname is empty" || echo "current hostname is $SHORTNAME"

#### On DeployStudio Runtime Only ####
if [[ $DSHOST && ${DSHOST-x} ]]; then
# Create host.txt file if doesn't exist
	[ ! -f "$DSITFOLD/host.txt" ] && /usr/bin/touch "$DSITFOLD/host.txt"
# Add deploystudio hostname value in host.txt
	echo "$DSHOST" > $DSITFOLD/host.txt
# Copy script itself in the IT folder for further use
	[ ! -f "$DSITFOLD/keephostname.sh" ] && cp "$0" $DSITFOLD/
######################################
fi

if [ -f "$ITFOLD/host.txt" ]; then
# Get previous saved hostname
LOWCOMNAME="$(cat $ITFOLD/host.txt)"
echo "previous saved hostname is $LOWCOMNAME"
# Make previous hostname uppercase
UPCOMNAME="$(echo $LOWCOMNAME | /usr/bin/tr '[:lower:]' '[:upper:]')"

# Check names values and change them if they differ from saved hostname
[ "$COMNAME" != "$UPCOMNAME" ] && /usr/sbin/scutil --set ComputerName $UPCOMNAME && echo "New ComputerName is $UPCOMNAME"
[ "$LOCANAME" != "$UPCOMNAME" ] && /usr/sbin/scutil --set LocalHostName $UPCOMNAME && echo "New LocalHostName is $UPCOMNAME"
[ "$SHORTNAME" != "$LOWCOMNAME" ] && /usr/sbin/scutil --set HostName $LOWCOMNAME.$DOMAIN && echo "New HostName is $LOWCOMNAME.$DOMAIN"
fi
sleep 15
exit 0