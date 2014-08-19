#!/bin/bash

# Change "admin" with your default IT short username
if [ "$USER" != "admin" ]; then
/usr/bin/open /Applications/Utilities/IT/MetaSkip.app
else 
/usr/bin/open /Applications/Utilities/IT/MetaSkip_Admin.app
fi
# delete user LaunchAgent
launchctl unload com.infernobox.firstrun.plist
rm -f /Users/$USER/Library/LaunchAgents/com.infernobox.firstrun.plist
exit 0

