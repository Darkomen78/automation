# MetaSkip
***

* MetaSkip.workflow and MetaSkip_Admin.workflow

Example workflow automator to edit several settings of user and adminstrator session

* firstrun.sh

Place this file in the **/Applications/Utilities/IT** folder
Launch the "MetaSkip" automator app (or MetaSkip_Admin for the IT local admin) at first login and delete **/Users/*$USER*/Library/LaunchAgents/com.infernobox.firstrun.plist** file to avoid auto launch at the second login 

* com.infernobox.firstrun.plist

Place this file in **/System/Library/User Template/Non_localized/Library/LaunchAgents/** (chmod 644 / chown root:wheel)
Launch the "firstrun.sh" script locate in the **/Applications/Utilities/IT** folder

