#!/bin/bash
# Version 06-2019
# Creator : Sylvain La Gravière
# Twitter : @darkomen78

# 10.XX / macOS minor version / Version mineur de macOS
macosver=$(sw_vers -productVersion | awk -F"." '{print$2}')

##########################
#### Customize that ####
##########################
ITFOLDER="/Users/Shared/IT"
CUSTOMSHARED="/Users/Shared"
CUSTOMTMP="/Users/Shared/tmp"

WALLPAPERFILE=$CUSTOMSHARED/wallpaper/user.png
USERPICFILE=$CUSTOMSHARED/users_pics/user.tif

LOCALDOMAIN=corp.infernobox.com

SAFARIHOMEPAGE='https://www.github.com/darkomen78'

DOCKAPPS=('Safari.app' 'Firefox.app' 'Google Chrome.app' 'Mail.app' 'Contacts.app' 'Notes.app' 'Microsoft Word.app' 'Microsoft Excel.app' 'Microsoft PowerPoint.app' 'VLC.app' 'iTunes.app' 'Adobe Acrobat DC/Adobe Acrobat.app' 'Adobe Acrobat DC/Adobe Distiller.app' 'Adobe Photoshop CC 2017/Adobe Photoshop CC 2017.app' 'Adobe InDesign CC 2017/Adobe InDesign CC 2017.app' 'Adobe Illustrator CC 2017/Adobe Illustrator.app' 'Adobe Photoshop CC 2018/Adobe Photoshop CC 2018.app' 'Adobe InDesign CC 2018/Adobe InDesign CC 2018.app' 'Adobe Illustrator CC 2018/Adobe Illustrator.app' 'System Preferences.app' 'Managed Software Center.app')

SERVERS=('venus' 'saturne' 'neptune' 'archives')

osascript -e 'display notification "Configuration de la session '$USER' en cours..." with title "Première ouverture de session"'
sleep 5
################################
######### Tweak System #########
################################
defaults -currentHost write com.apple.screensaver idleTime 1200
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 600
defaults write -g NSQuitAlwaysKeepsWindows -bool false
defaults write -g NSNavPanelExpandedStateForSaveMode -bool true
defaults write -g NSNavPanelExpandedStateForSaveMode2 -bool true
defaults write -g PMPrintingExpandedStateForPrint -bool true
defaults write -g PMPrintingExpandedStateForPrint2 -bool true
defaults write -g NSDocumentSaveNewDocumentsToCloud -bool false
defaults write com.apple.LaunchServices LSQuarantine -bool false
defaults write com.apple.CrashReporter DialogType -string "none"

############################
##### Mouse - Trackpad #####
############################
defaults write -g com.apple.swipescrolldirection -bool false
defaults write -g ApplePressAndHoldEnabled -bool false

################################
######### Tweak Finder #########
################################
defaults write com.apple.finder NewWindowTarget -string "PfLo"
defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}/"
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowMountedServersOnDesktop -bool true
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true
defaults write -g AppleShowAllExtensions -bool true
defaults write com.apple.finder ShowStatusBar -bool true
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.finder FXInfoPanesExpanded -dict \
General -bool true \
OpenWith -bool true \
Privileges -bool true
/usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist
defaults write com.apple.finder FXPreferredViewStyle -string "clmv"

####################################
#### Tweak Dock Mission control ####
####################################
defaults write com.apple.dock showhidden -bool true
defaults write com.apple.dock mru-spaces -bool false
defaults write com.apple.dock show-process-indicators -bool true
defaults write com.apple.dock show-recents -bool false


##############################
#### Don't touch this VVV ####
##############################
defaults write com.apple.dock 'persistent-apps' -array " "
sleep 3
ROOTAPPS="/Applications/"
for ADDAPP in "${DOCKAPPS[@]}"
do
	if [ -d "$ROOTAPPS$ADDAPP" ]; then
		defaults write com.apple.dock persistent-apps -array-add "<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>$ROOTAPPS$ADDAPP</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>"
	fi
done
if  [ "$macosver" == 15 ]; then
  ROOTAPPS="/System/Applications/"
for ADDAPP in "${DOCKAPPS[@]}"
do
  if [ -d "$ROOTAPPS$ADDAPP" ]; then
    defaults write com.apple.dock persistent-apps -array-add "<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>$ROOTAPPS$ADDAPP</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>"
  fi
done
fi

################################
#### You can touch that VVV ####
################################

####################################
########### Tweak Safari ###########
####################################
defaults write com.apple.Safari HomePage -string "$SAFARIHOMEPAGE"
defaults write com.apple.Safari AutoOpenSafeDownloads -bool false
defaults write com.apple.mail AddressesIncludeNameOnPasteboard -bool false

################################
#### Tweak Activity Monitor ####
################################
defaults write com.apple.ActivityMonitor ShowCategory -int 0
defaults write org.cups.PrintingPrefs DefaultPaperID iso-a4

#############################
#### Tweak User Account #####
#############################
# French
defaults write -g AppleLanguages -array fr-FR
defaults write -g AppleLocale fr_FR
defaults write -g AppleMeasurementUnits Centimeters
defaults write -g AppleMetricUnits -bool true
defaults write -g AppleTemperatureUnit Celsius

dscl . delete /Users/$USER Picture
dscl . delete /Users/$USER JPEGPhoto
dscl . append /Users/$USER Picture $USERPICFILE

if  (( $macosver < 15 )); then
$ITFOLDER/bin/wallpaper set $WALLPAPERFILE --scale center
fi

# Generate local servers shortcuts on the user's desktop
for SERVERNAME in "${SERVERS[@]}"
do
	echo "<?xml version="1.0" encoding="UTF-8"?>
	<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
	<plist version="1.0">
	<dict>
	<key>URL</key>
	<string>afp://$USER@$SERVERNAME.$LOCALDOMAIN</string>
	</dict>
	</plist>" > ~/Desktop/"$USER_$SERVERNAME".afploc
done

sleep 2
killall Dock
killall Finder

open $ITFOLDER/ConfigureUser/configure.command

exit 0
