#!/bin/bash
# Version 06-2019
# Creator : Sylvain La Gravière
# Twitter : @darkomen78

#### This script need a refactor ####

CUSTOMSHARED="/Users/Shared"
CUSTOMTMP="/Users/Shared/tmp"
PLBUDDY=/usr/libexec/PlistBuddy
# Use a simple SMTP relay without authentification
SMTPRELAY=smtp.infernobox.com:25

# Change default input to french
LANG="fr"
REGION="fr_FR"

# Save variables asked in MDS deployement dialog
mkdir -m775 "$CUSTOMTMP"
# QR-Code (TAG)
echo "$mds_var1" > $CUSTOMTMP/qr_code
# Munki option : 1 for Office / 2 for Graphist artist
echo "$mds_var2" > $CUSTOMTMP/munki_option
# Full final username : Surname NAME
echo "$mds_var3" > $CUSTOMTMP/full_username
# Final user password (on local server)
echo "$mds_var4" > $CUSTOMTMP/user_pass

chmod -R 777 $CUSTOMSHARED

while true; do sudo -n true; sleep 30; kill -0 "$$" || exit; done 2>/dev/null &

/usr/bin/defaults write /Library/Preferences/com.apple.loginwindow showInputMenu -bool true

languagesetup -langspec $LANG

defaults delete /Library/Preferences/com.apple.HIToolbox AppleEnabledInputSources
defaults write /Library/Preferences/com.apple.HIToolbox AppleCurrentKeyboardLayoutInputSourceID com.apple.keylayout.French
defaults write /Library/Preferences/com.apple.HIToolbox AppleEnabledInputSources -array '{ InputSourceKind = "Keyboard Layout"; "KeyboardLayout ID" = 1; "KeyboardLayout Name" = French; }'
defaults write /Library/Preferences/com.apple.HIToolbox AppleInputSourceHistory -array '{ InputSourceKind = "Keyboard Layout"; "KeyboardLayout ID" = 1; "KeyboardLayout Name" = French; }'
defaults write /Library/Preferences/com.apple.HIToolbox AppleSelectedInputSources -array '{ InputSourceKind = "Keyboard Layout"; "KeyboardLayout ID" = 1; "KeyboardLayout Name" = French; }'

update_language() {
  ${PLBUDDY} -c "Delete :AppleLanguages" "${1}" &>/dev/null
  if [ ${?} -eq 0 ]
  then
    ${PLBUDDY} -c "Add :AppleLanguages array" "${1}"
    ${PLBUDDY} -c "Add :AppleLanguages:0 string '${LANG}'" "${1}"
  fi
}

update_region() {
  ${PLBUDDY} -c "Delete :AppleLocale" "${1}" &>/dev/null
  ${PLBUDDY} -c "Add :AppleLocale string ${REGION}" "${1}" &>/dev/null
  ${PLBUDDY} -c "Delete :Country" "${1}" &>/dev/null
  ${PLBUDDY} -c "Add :Country string ${REGION:3:2}" "${1}" &>/dev/null
}

# Set computer language
update_language "/Library/Preferences/.GlobalPreferences.plist" "${LANG}"

for HOME in /Users/*
  do
    if [ -d "${HOME}"/Library/Preferences ]
    then
      cd "${HOME}"/Library/Preferences
      GLOBALPREFERENCES_FILES=`find . -name "\.GlobalPreferences.*plist"`
      for GLOBALPREFERENCES_FILE in ${GLOBALPREFERENCES_FILES}
      do
        update_language "${GLOBALPREFERENCES_FILE}" "${LANG}"
      done
    fi
done

# Set region
update_region "/Library/Preferences/.GlobalPreferences.plist" "${REGION}"

for HOME in /Users/*
  do
    if [ -d "${HOME}"/Library/Preferences ]
    then
      cd "${HOME}"/Library/Preferences
      GLOBALPREFERENCES_FILES=`find . -name "\.GlobalPreferences.*plist"`
      for GLOBALPREFERENCES_FILE in ${GLOBALPREFERENCES_FILES}
      do
        update_region "${GLOBALPREFERENCES_FILE}" "${REGION}"
      done
    fi
done

# Set Default Papert size
defaults write org.cups.PrintingPrefs DefaultPaperID iso-a4

# Add Computer TAG in ARD info (for Munki Report)
/System/Library/CoreServices/RemoteManagement/ARDAgent.app/Contents/Resources/kickstart -configure -computerinfo -set1 -1 "$mds_var1"

# Add munki command and power management in the sudoers file for the script admin (for the admin local user only)
echo "admin ALL=NOPASSWD: /usr/local/munki/managedsoftwareupdate,/usr/bin/pmset" >> /private/etc/sudoers

# Add relay mail host for admin script end notifications
echo "relayhost = $SMTPRELAY" >> /etc/postfix/main.cf

exit 0
