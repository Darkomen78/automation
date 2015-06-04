# FirstRun
***


* LaunchAgents

Copy both **.plist** files to **/System/Library/User Template/Non_localized/Library/LaunchAgents**
*chown root:wheel / chmod 644*
Those files Autolaunch "firstrun script" (see below) when normal users or administrators login for the first time.


* Firstrun Script

Copy both **.sh** files to the **/Applications/Utilities/IT/** folder
*chown admin:staff / chmod 755*
Edit them to fill your needs

* Default Wallpaper

If you wanna change default wallpaper (see inside *.sh* files, users and administrators wallpaper path aren't the same), copy also **set_desktops.py** to the **/Applications/Utilities/IT/** folder and *default.jpg* in **/Users/Shared/wallpaper/** (or use any .jpg file)


* DeployStudio Users

Copy task can be used to place files in the right folder