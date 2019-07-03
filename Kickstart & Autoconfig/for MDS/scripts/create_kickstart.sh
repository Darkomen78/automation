#!/bin/bash
# Version 07-2019
# Creator : Sylvain La Gravière
# Twitter : @darkomen78

################################
#### You can touch that VVV ####
################################
CUSTOMSHARED=/Users/Shared/
SRCSRV=http://my.webserver.com
SRCKICK=$SRCSRV/com.github.darkomen78.kickstart.plist
TEMPLATELANG=French

##############################
#### Don't touch this VVV ####
##############################

# 10.XX / macOS minor version / Version mineur de macOS
macosver=$(sw_vers -productVersion | awk -F"." '{print$2}')

if [ "$macosver" == 15 ]; then
  ROOTKICK=/Library/User\ Template/$TEMPLATELANG.lproj/Library/LaunchAgents
else
  ROOTKICK=/System/Library/User\ Template/$TEMPLATELANG.lproj/Library/LaunchAgents
fi
DSTKICK=$ROOTKICK/com.github.darkomen78.kickstart.plist

# Copy kickstart LauchAgent
mkdir -p "$ROOTKICK"
curl -s "$SRCKICK" > "$DSTKICK"
# Copy custom shared and untar
curl -s $SRCSRV/custom.tar -o /tmp/custom.tar
tar -zxvf /tmp/custom.tar -C $CUSTOMSHARED
rm /tmp/custom.tar
chown -R admin:staff $CUSTOMSHARED && chmod -R 755 $CUSTOMSHARED*
exit 0
