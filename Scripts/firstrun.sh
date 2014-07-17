#!/bin/bash
  
# Determine OS version
osvers=$(sw_vers -productVersion | awk -F. '{print $2}')
  
# Open App and delete LaunchAgent
/usr/bin/open /Applications/Utilities/IT/MetaSkip.app && rm -f /Users/$USER/Library/LaunchAgents/com.infernobox.firstrun.plist

exit 0

