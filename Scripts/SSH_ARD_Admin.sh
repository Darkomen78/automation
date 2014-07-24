#!/bin/bash

while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# user shortname who need to have ssh and ARD access
account=admin

# remove all groups and users who have already access
/usr/bin/dscl . delete /Groups/com.apple.access_ssh groupmembers
/usr/bin/dscl . delete /Groups/com.apple.access_ssh nestedgroups
/usr/bin/dscl . delete /Groups/com.apple.access_screensharing groupmembers
/usr/bin/dscl . delete /Groups/com.apple.access_screensharing nestedgroups
/usr/bin/dscl . delete /Groups/com.apple.local.ard_admin groupmembers
/usr/bin/dscl . delete /Groups/com.apple.local.ard_admin nestedgroups

# add ssh user
/usr/bin/dscl . append /Groups/com.apple.access_ssh user $account 
# add the GeneratedUID for the ssh user
/usr/bin/dscl . append /Groups/com.apple.access_ssh groupmembers `dscl . read /Users/$account GeneratedUID | cut -d " " -f 2` 

# activate SSH and ARD
/usr/sbin/systemsetup -setremotelogin on
/System/Library/CoreServices/RemoteManagement/ARDAgent.app/Contents/Resources/kickstart -configure -access -off -restart -agent
/System/Library/CoreServices/RemoteManagement/ARDAgent.app/Contents/Resources/kickstart -configure -allowAccessFor -specifiedUsers
/System/Library/CoreServices/RemoteManagement/ARDAgent.app/Contents/Resources/kickstart -activate -configure -users $account -access -on -privs -all -restart -agent

exit 0