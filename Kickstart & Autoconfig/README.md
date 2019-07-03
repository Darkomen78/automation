No DEP no MDM starter Kit
==========
### Custom tools and script to make a "not so bad" automatic 10.14 install on T2 (or not) devices without DEP nor MDM (but please, listen Apple and get an MDM).

Example in motion : [macOS 10.14 Mojave automatic install on T2 device](https://www.youtube.com/watch?v=xFASDulnU48)

* The "For MDS" folder
Scripts are based on MDS variables but you can adjust them with other tools, I guess...
Profiles can be used anywhere, they complete general user/computer configuration of the configuration.sh script.
If you don't know MDS take a look [here](https://twocanoes.com/products/mac/mac-deploy-stick/) and [here]( https://bitbucket.org/twocanoes/macdeploystick/downloads/)

* The "For Webserver" folder
custom.tar is just a TAR-file version of the "custom items" folder's content.
com.github.darkomen78.kickstart.plist is a launchagent used only once at the first login for each user.

* The "custom items" folder
In my design, all content of this folder must go into /User/Shared/ to be used by scripts.
  * users_pics and wallpaper folders speak for themselves.
  * The IT folder got three sub-folders :
    * bin for the active part, [pycreateuserpkg](https://github.com/gregneagle/pycreateuserpkg) is a really good tool by Greg Neagle and [wallpaper](https://github.com/sindresorhus/macos-wallpaper/releases) by sindresorhus
    * kickstart.sh just launch admin.command (and show progress window) for the local admin user only or user.sh script for all others users
    * scripts folder with the two script admin.command and user.sh, check them and modify script to meet your needs.   
      * admin.command is well commented. It launch after the first (auto)login of the local admin user and do this :
        1. Configure admin settings
        2. Configure admin Dock (see DOCKAPPS var)
        3. Configure admin wallpaper (not on 10.15 for now)
        4. Launch Munki on a specific manifest (see munkioption var)
        5. Send a mail to the IT Team with computer informations (with MDS values)
        6. Logout (not on 10.15 for now)
      * user.sh do little less things than the admin.command script :
        1. Configure user settings (silent)
        2. Configure user Dock (silent)
        3. Configure user wallpaper (silent and not on 10.15 for now)
        4. Make some .afploc files with embedded username on Desktop to quickly connect servers.
        5. Launch configure.command script (with MDS values) of the ConfigureUser folder
    * ConfigureUser folder help you to configure quickly IMAP mail account, TimeMachine network share and L2TP VPN, all are based on the same shortname as the local user account and password provide by MDS or manually at the beginning of the script. Again, check and modify all three mobileconfig files to meet your needs.   

**To suppress the admin autologin after apps deployment** you can use a nopkg script for munki like this :

    #!/bin/bash
    defaults delete /Library/Preferences/com.apple.loginwindow autoLoginUser
    rm /etc/kcpassword
    exit 0

Just add it in all deployment manifest (see munkioption)
