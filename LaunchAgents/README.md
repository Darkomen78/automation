LaunchAgents
==========

• com.adobe.AUSST.updater.plist

Can be use with the LaunchAgent "AUSSTupdate.sh"
Launch the incremental update all saturday at five in the morning

• com.infernobox.firstrun.plist

Use only with the script "firstrun.sh" (see README.md in Scripts subfolder)
Launch the "firstrun" script locate in the /Applications/Utilities/IT folder at first login and delete "/Users/$USER/Library/LaunchAgents/com.infernobox.firstrun.plist" file to avoid auto launch at next login

