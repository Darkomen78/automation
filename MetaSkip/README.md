# MetaSkip
***

## NEW full bash verion coming up !

* MetaSkip.workflow and MetaSkip_Admin.workflow

Example workflow automator to edit several settings of user and administrator session

* firstrun.sh

Place this file in the **/Applications/Utilities/IT** folder
Launch the "MetaSkip" automator app (or MetaSkip_Admin for the IT local admin) at first login and delete **/Users/*$USER*/Library/LaunchAgents/com.infernobox.firstrun.plist** file to avoid auto launch at the second login 

* com.infernobox.firstrun.plist

Place this file in **/System/Library/User Template/Lang.lproj/Library/LaunchAgents/** 
*chown root:wheel and chmod 644*
Launch the "firstrun.sh" script locate in the **/Applications/Utilities/IT** folder

