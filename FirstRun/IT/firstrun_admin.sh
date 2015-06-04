#!/bin/bash

# Version 1.0 by Sylvain La Gravière
# Twitter : @darkomen78
# Mail : darkomen@me.com

FULLOSVERSION=$(sw_vers -productVersion)

WALLPAPERFILE=/Applications/Utilities/IT/wallpaper.jpg
# USERPICFILE=/Users/Shared/user.tif
ITFOLDER=/Applications/Utilities/IT
ADMINUSR=admin

SAFARIHOMEPAGE='http://munki.infernobox.com'
# Fastswitch user menu (YES ou NO )
SWITCHUSER='NO'

# Delete launch file
rm -f ~/Library/LaunchAgents/com.infernobox.firstrun_admin.plist

if [ "$USER" = "cliczone" ]; then
####################################	
#### ADMIN SETTINGS SCRIPT BEGIN ####
####################################
####################################
####################################

osascript -e 'display notification "Please wait, settings in progress..."'
say "Please wait, settings in progress..."
sleep 15

# Tweak System

# Fastswitch user menu
defaults write NSGlobalDomain MultipleSessionEnabled -bool $SWITCHUSER

# Screensaver
## Main delay
defaults -currentHost write com.apple.screensaver idleTime 600
## Ask for password
defaults write com.apple.screensaver askForPassword -int 1
## Password delay
defaults write com.apple.screensaver askForPasswordDelay -int 600

# Remove "Reopen windows on next login"
defaults write NSGlobalDomain NSQuitAlwaysKeepsWindows -bool false

# Remove TimeMachine from menu
defaults -currentHost write com.apple.systemuiserver dontAutoLoad -array-add "/System/Library/CoreServices/Menu Extras/TimeMachine.menu"
defaults -currentHost write com.apple.systemuiserver menuExtras -array "/System/Library/CoreServices/Menu Extras/Bluetooth.menu" "/System/Library/CoreServices/Menu Extras/AirPort.menu" "/System/Library/CoreServices/Menu Extras/Battery.menu" "/System/Library/CoreServices/Menu Extras/Clock.menu" "/System/Library/CoreServices/Menu Extras/TextInput.menu"

# Show battery time
defaults write com.apple.menuextra.battery ShowPercent -string "NO"
defaults write com.apple.menuextra.battery ShowTime -string "YES"

# Always show scrollbars
defaults write NSGlobalDomain AppleShowScrollBars -string "Always"

# Big save dialogs
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true

# Big print dialogs
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint2 -bool true

# Local save (instead of iCloud save)
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

# Remove first app open alert popup
defaults write com.apple.LaunchServices LSQuarantine -bool false

# Remove Crash Reporter 
defaults write com.apple.CrashReporter DialogType -string "none"

# Tweak Mouse - Trackpad

# Natural scroll off
defaults write NSGlobalDomain com.apple.swipescrolldirection -bool false

# Press and Hold for accented characters
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false

# Tweak Finder

# Home folder on Finder new window
defaults write com.apple.finder NewWindowTarget -string "PfLo"
defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}/"

# All icons on desktop
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowMountedServersOnDesktop -bool true
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true

# Show all extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Show status bar
defaults write com.apple.finder ShowStatusBar -bool true

# Search in current folder
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

# Désactiver l'avertissement lors du changement d'une extensions
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# No more .DS_Store on network volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

# Show user's library
chflags nohidden ~/Library

# General, Open with, Sharing and Permissions expanded in Info Windows
defaults write com.apple.finder FXInfoPanesExpanded -dict \
	General -bool true \
	OpenWith -bool true \
	Privileges -bool true

# Snap to grid
/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist	
# Always use column view
defaults write com.apple.finder FXPreferredViewStyle -string "clmv"

# Tweak Dock and Mission control

# Show open app indicator
defaults write com.apple.dock show-process-indicators -bool true

# Empty Dock
/usr/bin/defaults write com.apple.dock 'persistent-apps' -array " "

# Add items in dock

# Applications

/usr/bin/defaults write com.apple.dock 'persistent-apps' -array-add '<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/Applications/Safari.app/</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>'

/usr/bin/defaults write com.apple.dock 'persistent-apps' -array-add '<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/Applications/Firefox.app/</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>'

/usr/bin/defaults write com.apple.dock 'persistent-apps' -array-add '<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/Applications/Google Chrome.app/</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>'

/usr/bin/defaults write com.apple.dock 'persistent-apps' -array-add '<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/Applications/Utilities/Console.app/</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>'

/usr/bin/defaults write com.apple.dock 'persistent-apps' -array-add '<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/Applications/Utilities/Terminal.app/</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>'

/usr/bin/defaults write com.apple.dock 'persistent-apps' -array-add '<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/Applications/Utilities/Activity Monitor.app/</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>'

/usr/bin/defaults write com.apple.dock 'persistent-apps' -array-add '<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/Applications/Utilities/Migration Assistant.app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>'

/usr/bin/defaults write com.apple.dock 'persistent-apps' -array-add '<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/Applications/Utilities/Keychain Access.app/</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>'

/usr/bin/defaults write com.apple.dock 'persistent-apps' -array-add '<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/Applications/Utilities/Disk Utility.app/</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>'

/usr/bin/defaults write com.apple.dock 'persistent-apps' -array-add '<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/Applications/Managed Software Center.app/</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>'

# Autres, folder, alias, documents
# Options : 
# displayas = 0 stack, 1 folder
# showas = 0 auto, 1 éventail, 2 grille, 3 list 

/usr/bin/defaults write com.apple.dock 'persistent-others' -array-add "<dict><key>tile-data</key><dict><key>arrangement</key><integer>0</integer><key>displayas</key><integer>1</integer><key>file-data</key><dict><key>_CFURLString</key><string>/Users/Shared/Serveurs/</string><key>_CFURLStringType</key><integer>0</integer></dict><key>preferreditemsize</key><integer>-1</integer><key>showas</key><integer>3</integer></dict><key>tile-type</key><string>directory-tile</string></dict>"
/usr/bin/defaults write com.apple.dock 'persistent-others' -array-add "<dict><key>tile-data</key><dict><key>arrangement</key><integer>0</integer><key>displayas</key><integer>0</integer><key>file-data</key><dict><key>_CFURLString</key><string>/Applications/Utilities/Cliczone/</string><key>_CFURLStringType</key><integer>0</integer></dict><key>preferreditemsize</key><integer>-1</integer><key>showas</key><integer>3</integer></dict><key>tile-type</key><string>directory-tile</string></dict>"

# Put Dashboard off
defaults write com.apple.dashboard mcx-disabled -bool true

# Hidden apps icons in dock are transparent
defaults write com.apple.dock showhidden -bool true

# Don't rearrange spaces
defaults write com.apple.dock mru-spaces -bool false

# Tweak Time Machine

# no more auto ask for TimeMachine when you mount external disk
defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true

# Tweak Safari

# Safari home page
defaults write com.apple.Safari HomePage -string "$SAFARIHOMEPAGE"

# Don't open downloaded files
defaults write com.apple.Safari AutoOpenSafeDownloads -bool false

# Safari Dev/Debug menu
# defaults write com.apple.Safari IncludeInternalDebugMenu -bool true
# defaults write com.apple.Safari IncludeDevelopMenu -bool true
# defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
# defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled -bool true
# defaults write NSGlobalDomain WebKitDeveloperExtras -bool true

# Tweak Mail

# command + enter send mail
defaults write com.apple.mail NSUserKeyEquivalents -dict-add "Send" -string "@\\U21a9"

# Copy/Paste adress
defaults write com.apple.mail AddressesIncludeNameOnPasteboard -bool false

# Tweak Activity Monitor

# Show all process
defaults write com.apple.ActivityMonitor ShowCategory -int 0

# Tweak Gatekeeper

# Allow anywhere
spctl --master-disable

# Tweak first login
defaults write ~/Library/Preferences/com.apple.SetupAssistant DidSeeCloudSetup -bool TRUE
defaults write ~/Library/Preferences/com.apple.SetupAssistant LastSeenCloudProductVersion "$FULLOSVERSION"
defaults write ~/Library/Preferences/com.apple.SetupAssistant GestureMovieSeen none

# Change user picture
dscl . delete /Users/$USER Picture
dscl . delete /Users/$USER JPEGPhoto
dscl . append /Users/$USER Picture $USERPICFILE

# Change user wallpaper
if [ -f $ITFOLDER/set_desktops.py ]; then
python $ITFOLDER/set_desktops.py --path $WALLPAPERFILE
fi

# Check munki on first logoff
touch /Users/Shared/.com.googlecode.munki.checkandinstallatstartup

# Teak Contacts

# Add LDAP server
# /usr/bin/defaults write com.apple.AddressBook 'AB3LDAPServers' -array-add '<dict><key>ServerInfo</key><dict><key>AuthenticationType</key><false/><key>Base</key><string>dc=infernobox,dc=com</string><key>Disabled</key><false/><key>Enabled</key><true/><key>HostName</key><string>ldap.inernobox.com</string><key>IgnoresSSLCertErrorsIdentifier</key><false/><key>Port</key><integer>389</integer><key>SSL</key><false/><key>Scope</key><integer>2</integer><key>Title</key><string>LDAP Infernobox</string><key>UID</key><string>5FEF20A9-8D82-48F7-8C8B-31C27586E2AC</string></dict><key>ServerType</key><integer>0</integer></dict>'
# /usr/bin/defaults write com.apple.AddressBook "ABCleanWindowController-MainCleanWindow-groupList" '<dict><key>selectedGroupEntryIdentifier</key><string>ABSearchingGroupEntry:5FEF20A9-8D82-48F7-8C8B-31C27586E2AC</string></dict>'

# Restart Dock, Finder and logout
killall Dock
killall Finder

####################################
####################################
####################################
##### ADMIN SETTINGS SCRIPT END #####
####################################
osascript <<EOD
	tell application "System Events"
		log out
	end tell
EOD
fi
exit 0