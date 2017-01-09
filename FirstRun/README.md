# FirstRun
***


* LaunchAgents

Copy both **.plist** files to **/System/Library/User Template/Non_localized/Library/LaunchAgents** <br />  
*chown root:wheel
chmod 644*<br />
Those files autolaunch "firstrun script" (see below) when normal users or administrators login for the first time.
 <br />
* Firstrun Script

Copy both **.sh** files to the **/Applications/Utilities/IT/** folder

*chown admin:staff
chmod 755*

**Edit them to fill your needs**
 <br />  
* Default Wallpaper

If you wanna change default wallpaper (see inside *.sh* files, users and administrators wallpaper path can be different), copy also **set_desktops.py** to the **/Applications/Utilities/IT/** folder and *default.jpg* in **/Users/Shared/wallpaper/** (or use any .jpg file)


* For DeployStudio Users

Runtime "copy task" can be used to move files in the right folder
