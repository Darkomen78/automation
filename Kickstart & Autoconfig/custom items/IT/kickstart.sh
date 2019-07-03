#!/bin/bash

# Version 07-2019
# Creator : Sylvain La Gravière
# Twitter : @darkomen78


ITFOLDER="/Users/Shared/IT"
rm -f ~/Library/LaunchAgents/com.github.darkomen78.kickstart.plist
if [ "$USER" = "admin" ]; then
	open $ITFOLDER/scripts/admin.command
	exit 0
else
	$ITFOLDER/scripts/user.sh
	exit 0
fi
exit 0
