#!/bin/bash
# Version 06-2019
# Creator : Sylvain La Gravière
# Twitter : @darkomen78

ITFOLDER="/Users/Shared/IT"
CUSTOMSHARED="/Users/Shared"
CUSTOMTMP="/Users/Shared/tmp"

if [ -f "$CUSTOMTMP/full_username" ]; then
  USRFULLNAME="$(cat $CUSTOMTMP/full_username)"
else
  USRFULLNAME=$(id -P $(stat -f%Su /dev/console) | cut -d : -f 8)
fi
mkdir -p $CUSTOMTMP
cp $ITFOLDER/ConfigureUser/configs/* $CUSTOMTMP/

read -p "Configuration automatique pour l'utilisateur $USER, continuer ? [O]" -n 1 -r
echo
if [[ $REPLY =~ ^[Nn]$ ]]; then
  exit 0
else
  if [ -f "$CUSTOMTMP/user_pass" ]; then
    CUSTOMPASS="$(cat $CUSTOMTMP/user_pass)"
  else
    echo -n "Entrer le mot de passe pour $USER : "
    read -s CUSTOMPASS
    echo
  fi
  # Config mail
  read -p "Configuration de la boite mail pour l'utilisateur $USER, continuer ? [O]" -n 1 -r
  echo
  if [[ $REPLY =~ ^[Nn]$ ]]; then
    echo "configuration suivante..."
  else
    sed -i .tmp "s/thisUSER/$USER/g" "$CUSTOMTMP/IMAP.mobileconfig"
    sed -i .tmp "s/thisLONGUSER/$USRFULLNAME/g" "$CUSTOMTMP/IMAP.mobileconfig"
    sed -i .tmp "s/thisPASS/$CUSTOMPASS/g" "$CUSTOMTMP/IMAP.mobileconfig"
    open "$CUSTOMTMP/IMAP.mobileconfig"
    read -p "Appuyer sur entrée quand le profil IMAP est installé..."
    open "/Applications/Mail.app"
  fi
  # Config VPN
  read -p "Configuration du VPN pour l'utilisateur $USER, continuer ? [O]" -n 1 -r
  echo
  if [[ $REPLY =~ ^[Nn]$ ]]; then
    echo "configuration suivante..."
  else
    echo "Configuration du VPN pour $USER"
    sed -i .tmp "s/thisUSER/$USER/g" "$CUSTOMTMP/VPN.mobileconfig"
    sed -i .tmp "s/thisPASS/$CUSTOMPASS/g" "$CUSTOMTMP/VPN.mobileconfig"
    open "$CUSTOMTMP/VPN.mobileconfig"
    read -p "Appuyer sur entrée quand le profil VPN est installé..."
    open "/System/Library/CoreServices/Menu Extras/VPN.menu"
  fi

  # Config TimeMachine
  read -p "Configuration TimeMachine pour l'utilisateur $USER, continuer ? [O]" -n 1 -r
  echo
  if [[ $REPLY =~ ^[Nn]$ ]]; then
    echo "fin de la configuration."
  else
    open "$CUSTOMTMP/TM.mobileconfig"
    read -p "Appuyer sur entrée quand le profil TimeMachine est installé..."
    open "/System/Library/CoreServices/Menu Extras/TimeMachine.menu"
    open "/System/Library/PreferencePanes/TimeMachine.prefPane"
    echo "fin de la configuration."
  fi

# Remove useless files
rm -R $CUSTOMTMP
exit 0
fi
