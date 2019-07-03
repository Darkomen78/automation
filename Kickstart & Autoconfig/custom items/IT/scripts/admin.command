#!/bin/bash
# Version 07-2019
# Creator : Sylvain La Gravière
# Twitter : @darkomen78

# 10.XX / macOS minor version / Version mineur de macOS
macosver=$(sw_vers -productVersion | awk -F"." '{print$2}')

# Computer name / Nom de l'ordinateur
hostname=$(hostname)

# Customization folders and files path / Emplacements des dossiers et fichiers
ITFOLDER="/Users/Shared/IT"
CUSTOMSHARED="/Users/Shared"
CUSTOMTMP="/Users/Shared/tmp"
WALLPAPERFILE=$CUSTOMSHARED/wallpaper/admin.png
USERPICFILE=$CUSTOMSHARED/users_pics/admin.tif

# User's variables (from configuration MDS main script) / Variables utilisateurs (depuis le script configuration dans MDS)
USRFULLNAME=$(cat $CUSTOMTMP/full_username)
munkioption=$(cat $CUSTOMTMP/munki_option)
QRCODE=$(cat $CUSTOMTMP/qr_code)

# If user enter "none" on MDS only local admin will be created / Si l'utilisateur entre "non" sur MDS, seul le compte admin sera créé
case "$USRFULLNAME" in
  [Nn][Oo][Nn][Ee] | [Nn][Oo][Nn] | [Nn][Oo]) USRFULLNAME="None" ;;
  "") USRFULLNAME="None" ;;
  *) echo "Compte $USRFULLNAME" ;;
esac

# Each option is a different manifest in Munki server / Chaque option est un manifeste différent sur le serveur Munki
if [[ "$munkioption" = "1" ]]; then
  munkioption=PAO
else
  munkioption=Office
fi

# Safari homepage / Page d'accueil de Safari
SAFARIHOMEPAGE='http://www.apple.com'

# Apps list to add in Dock, works for 10.15 system apps too / Liste des applications à ajouter dans le Dock de l'utilisateur. Fonctionne également avec les apps préinstallées sur 10.15
DOCKAPPS=('Safari.app' 'Firefox.app' 'Google Chrome.app' 'Utilities/Console.app' 'Utilities/Terminal.app' 'Utilities/Activity Monitor.app' 'Utilities/Migration Assistant.app' 'Utilities/Keychain Access.app' 'Utilities/Disk Utility.app' 'Managed Software Center.app')

osascript -e 'display notification "Administrator config in progress..." with title "Please wait"'
sleep 3

##################
##### System #####
##################
# Screensaver delay in seconds / Délais pour le sauveur d’écran en secondes
defaults -currentHost write com.apple.screensaver idleTime 600
# Ask for password / Demande le mot de passe
#defaults write com.apple.screensaver askForPassword -int 1
# Ask for password delay in seconds / Délais avant la demande du mot de passe
#defaults write com.apple.screensaver askForPasswordDelay -int 5

# Reopen apps after reboot or shutdown / Réouverture des applications après l’exctinction
defaults write -g NSQuitAlwaysKeepsWindows -bool false

# Expand save windows / Agrandir les dialogues de sauvegarde
defaults write -g NSNavPanelExpandedStateForSaveMode -bool true
defaults write -g NSNavPanelExpandedStateForSaveMode2 -bool true

# Expand print windows / Agrandir les dialogues d'impression
defaults write -g PMPrintingExpandedStateForPrint -bool true
defaults write -g PMPrintingExpandedStateForPrint2 -bool true

# Save file on local disk instead of iCloud / Sauvegarder par défaut sur le disque local (et non iCloud)
defaults write -g NSDocumentSaveNewDocumentsToCloud -bool false

# Warning message for downloaded app / Message d'alerte à la première ouverte d'une application téléchargée
defaults write com.apple.LaunchServices LSQuarantine -bool false

# Remove the crash reporter / Désactiver le Crash Reporter
defaults write com.apple.CrashReporter DialogType -string "none"

############################
##### Mouse - Trackpad #####
############################
# Uncheck "natural scroll" / Désactiver le "défilement naturel"
defaults write -g com.apple.swipescrolldirection -bool false
defaults write com.apple.driver.AppleHIDMouse Button2 -int 2
defaults write com.apple.driver.AppleBluetoothMultitouch.mouse MouseButtonMode -string TwoButton
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadRightClick -int 1

####################
##### Keyboard #####
####################
# Uncheck hold letter for accent / Désactiver la "pression maintenue" pour les lettres accentuées
defaults write -g ApplePressAndHoldEnabled -bool false

########################
##### Tweak Finder #####
########################
# New Finder windows show user home folder / Les fenêtres du Finder affiche le dossier utilisateur par défaut
# Others options are
# Computer     : `PfCm`
# Volume       : `PfVo`
# $HOME        : `PfHm`
# Desktop      : `PfDe`
# Documents    : `PfDo`
# All My Files : `PfAF`
# Other…       : `PfLo`
defaults write com.apple.finder NewWindowTarget -string "PfLo"
defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}/"

# Show all icons on Desktop / Activer toutes les icones sur le bureau
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowMountedServersOnDesktop -bool true
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true

# Show full filename / Afficher toutes les extensions
defaults write -g AppleShowAllExtensions -bool true

# Show status bar / Afficher la barre d'état
defaults write com.apple.finder ShowStatusBar -bool true

# Search in the home folder by default / La recherche ce fait dans le dossier courant par défaut
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

# No warning on extension change / Désactiver l'avertissement lors du changement d'une extensions
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# Don't write .DS_Store on network drives / Empêche la création de .DS_Store sur les volumes réseaux
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

# Show "General", "Open with" and "Privileges" by default in the file info window / Affiche les onglets “General”, “Ouvrir avec”, et “Permissions” dans les fenêtres d'info
defaults write com.apple.finder FXInfoPanesExpanded -dict \
General -bool true \
OpenWith -bool true \
Privileges -bool true

# Keep icons on grid / Aligne par défaut les icones sur une grille
/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist

# Default view in column / Utiliser la vue en colonne
defaults write com.apple.finder FXPreferredViewStyle -string "clmv"

####################################
#### Tweak Dock Mission control ####
####################################

# Show open app indicator / Affiche l'indicateur d'application ouverte
defaults write com.apple.dock show-process-indicators -bool true

# Hidden apps are transparent / Les applications masquées sont transparentes
defaults write com.apple.dock showhidden -bool true

# Don't automatically rearrange spaces / Ne pas réarranger les espaces automatiquement
defaults write com.apple.dock mru-spaces -bool false

##############################
#### Don't touch this VVV ####
##############################

# Empty dock / Vide le dock
defaults write com.apple.dock 'persistent-apps' -array " "
sleep 3
# Add apps in Dock / Ajout des Applications dans le Dock
ROOTAPPS="/Applications/"
for ADDAPP in "${DOCKAPPS[@]}"
do
  if [ -d "$ROOTAPPS$ADDAPP" ]; then
    defaults write com.apple.dock persistent-apps -array-add "<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>$ROOTAPPS$ADDAPP</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>"
  fi
done
# Add 10.15 system and base apps
if  [ "$macosver" == 15 ]; then
  ROOTAPPS="/System/Applications/"
for ADDAPP in "${DOCKAPPS[@]}"
do
  if [ -d "$ROOTAPPS$ADDAPP" ]; then
    defaults write com.apple.dock persistent-apps -array-add "<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>$ROOTAPPS$ADDAPP</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>"
  fi
done
defaults write com.apple.dock persistent-apps -array-add "<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/System/Library/PreferencesPanes/Accounts.prefPane</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>"
fi


# Others items than apps : folders, alias, documents / Les autres éléments qui ne sont pas des apps : dossiers, alias, documents

# Options :
# displayas = display as : 0 stack, 1 folder / afficher comme : 0 pile, 1 dossier
# showas = view content as : 0 auto, 1 fan, 2 grid, 3 list / afficher le contenu comme : 0 auto, 1 éventail, 2 grille, 3 liste

# Example
# defaults write com.apple.dock 'persistent-others' -array-add "<dict><key>tile-data</key><dict><key>arrangement</key><integer>0</integer><key>displayas</key><integer>0</integer><key>file-data</key><dict><key>_CFURLString</key><string>/Users/Shared/IT/</string><key>_CFURLStringType</key><integer>0</integer></dict><key>preferreditemsize</key><integer>-1</integer><key>showas</key><integer>3</integer></dict><key>tile-type</key><string>directory-tile</string></dict>"

################################
#### You can touch that VVV ####
################################

########################
##### Tweak Safari #####
########################

# Homepage / Page de démarrage
defaults write com.apple.Safari HomePage -string "$SAFARIHOMEPAGE"

# Don't automatically open "safe files" after downloading / Ne pas ouvrir automatiquement les fichiers "sûrs""
defaults write com.apple.Safari AutoOpenSafeDownloads -bool false

# Show debug menu / Activer le menu developpeur
defaults write com.apple.Safari IncludeInternalDebugMenu -bool true
defaults write com.apple.Safari IncludeDevelopMenu -bool true
defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled -bool true
defaults write -g WebKitDeveloperExtras -bool true

####################
#### Tweak Mail ####
####################

# Email adress copy only / Simplifie le copier coller d'adresse
defaults write com.apple.mail AddressesIncludeNameOnPasteboard -bool false

################################
#### Tweak Activity Monitor ####
################################

# Show all processes / Affiche tous les processus
defaults write com.apple.ActivityMonitor ShowCategory -int 0

#############################
#### Tweak User Account #####
#############################

# Region and langage settings / Réglages région et langue
# French
defaults write -g AppleLanguages -array fr-FR
defaults write -g AppleLocale fr_FR
defaults write -g AppleMeasurementUnits Centimeters
defaults write -g AppleMetricUnits -bool true
defaults write -g AppleTemperatureUnit Celsius

# Change user picture / Changement de l’avatar
dscl . delete /Users/$USER Picture
dscl . delete /Users/$USER JPEGPhoto
dscl . append $HOME Picture $USERPICFILE

# Change wallpaper / Changement du fond d'écran
# Need a notarized app to work on Catalina
if  (( $macosver < 15 )); then
$ITFOLDER/bin/wallpaper set $WALLPAPERFILE
fi

# Launch Munki on the "munkioption" manifest / Active Munki sur le manifest "munkioption"
osascript -e "display notification \"Installation des applications en cours...\" with title \"Munki "$munkioption"\""
sudo pmset -c sleep 0
sudo /usr/local/munki/managedsoftwareupdate -v --id=$munkioption --munkipkgsonly
# sleep 5 && open "/Library/Managed Installs/Logs/ManagedSoftwareUpdate.log"
sudo /usr/local/munki/managedsoftwareupdate --installonly
touch $CUSTOMSHARED/.com.googlecode.munki.checkandinstallatstartup

# Activate the dark mode / Activation du mode sombre
if  (( $macosver > 13 )); then
defaults write -g AppleInterfaceStyle Dark
fi

# Add some info on login screen / Ajout les infos machines sur l'écran de login
touch /Library/Preferences/com.apple.loginwindow
/usr/bin/defaults write /Library/Preferences/com.apple.loginwindow AdminHostInfo HostName
/usr/bin/defaults write /Library/Preferences/com.apple.loginwindow LoginwindowText "Installation $(date +"%d-%m-%y")"

# Restart Dock and Finder to get new settings / Relance le Dock et le Finder pour valider les réglages
sleep 2
killall Dock
killall Finder

# Send mail to IT team with deployement informations / Envoi un mail à l'équipe IT avec les infos de déploiement du poste
### SMTP relay must be add in /etc/postfix/main.cf (example in configuration MDS main script) /Un relais SMTP doit être ajouté dans le fichier /etc/postfix/main.cf (exemple dans le script configuration de MDS) ###
sendmail it@infernobox.com <<EOF
subject: $hostname is ready
from:deploy@pinfernobox.com

QR-Code : $QRCODE
Utilisateur : $USRFULLNAME
Option Munki : $munkioption

You know what to do next.

EOF

sleep 5

# Remove useless files
if [[ "$USRFULLNAME" = "None" ]]; then
  rm -R "$CUSTOMTMP"
fi

if  (( $macosver < 15 )); then
# Fermeture de la session
launchctl reboot logout
fi

exit 0
