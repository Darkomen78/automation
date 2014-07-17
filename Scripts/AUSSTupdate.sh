#!/bin/bash

# AUSST root folder full path 
AUSSTROOT='/AUSST'

# Create log file and folder
[ -d "$AUSSTROOT"/log ] || sudo mkdir "$AUSSTROOT"/log
[ -f "$AUSSTROOT"/log/incremental.log ] || sudo touch "$AUSSTROOT"/log/incremental.log 

# Adobe Local Server Incremental Update
"/Applications/Utilities/Adobe Application Manager/CCP/utilities/AUSST/AdobeUpdateServerSetupTool" --root="$AUSSTROOT" --incremental > "$AUSSTROOT"/log/incremental.log
exit 0

