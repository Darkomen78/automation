Sripts
==========

• addPDF9printer.sh

Copy Adobe PDF 9 PPD file from standard Acrobat 9 Pro install folder to the system and add Virtual Adobe PDF 9 printer


• AUSSTupdate.sh

Create log folder and .log file in the root folder of the Adobe Update Server Setup Tool and launch incremental update.
Can be use with the LaunchAgent "com.adobe.AUSST.updater.plist"


• firstrun.sh

Use only with the LaunchAgent "com.infernobox.firstrun.plist" (see README.md in LaunchAgents subfolder)
Launch the "MetaSkip" automator app at first login and delete "/Users/$USER/Library/LaunchAgents/com.infernobox.firstrun.plist" file to avoid second login auto launch


• SSH_ARD_Admin.sh

Remove all users and groups from SSH and ARD access and add only user specified in line 6 (default : admin)


• revision.sh

Show "initial today" date on the login screen in Day-Month-Year style.
Usefull to keep initial deployement date on computer. Best use in a DeployStudio workflow after a fresh restore.