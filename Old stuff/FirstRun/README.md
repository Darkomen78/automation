# FirstRun
***


* LaunchAgents
Copy both **.plist** files to **/System/Library/User Template/Non_localized/Library/LaunchAgents**
*chown root:wheel<br />chmod 644*<br />Those files autolaunch "firstrun script" (see below) when normal users or administrators login for the first time.<br /><br />

* Firstrun Script<br />Copy both **.sh** files to the **/Applications/Utilities/IT/** folder
*chown admin:staff<br />chmod 755*<br />**Edit them to fill your needs**<br /><br />

* Default Wallpaper
If you wanna change default wallpaper (see inside *.sh* files, users and administrators wallpaper path can be different), copy also **set_desktops.py** to the **/Applications/Utilities/IT/** folder and *default.jpg* in **/Users/Shared/wallpaper/** (or use any .jpg file)


* For DeployStudio Users
Copy task can be used to move files in the right folder
