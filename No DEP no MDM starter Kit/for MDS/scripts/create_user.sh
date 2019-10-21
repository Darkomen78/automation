#!/bin/bash
# Version 07-2019
# Creator : Sylvain La Gravière
# Twitter : @darkomen78

ITFOLDER="/Users/Shared/IT"
CUSTOMSHARED="/Users/Shared"
CUSTOMTMP="/Users/Shared/tmp"
USRFULLNAME=$(cat $CUSTOMTMP/full_username)
mkdir -p -m775 $CUSTOMTMP

# Local user password
USRPASSWORD=mylocalpassword

# Generate a random UID
USRID=$(( ( RANDOM % 40 )  + 505 ))

#keep the first letter of the full username for the shortname
USRSHORTNAME=${USRFULLNAME:0:1}

case "$USRFULLNAME" in
  [Nn][Oo][Nn][Ee] | [Nn][Oo][Nn] | [Nn][Oo]) exit 0 ;;
  "") rm $CUSTOMTMP/user_pass && exit 0 ;;
  *) echo "Création du compte $USRFULLNAME" ;;
esac

# Loop for long name
n=2
for i in $USRFULLNAME; do
ADDUSRSHORTNAME=$(echo "$USRFULLNAME" | awk -v var="$n" '{print $var}')
n=$((n+1))
USRSHORTNAME="$USRSHORTNAME$ADDUSRSHORTNAME"
done

# Format the shortname
USRSHORTNAME=$(echo "$USRSHORTNAME" | iconv -t ascii//TRANSLIT | sed -E 's/[~\^]+//g' | sed -E 's/[^a-zA-Z0-9]+//g' | sed -E 's/^-+\|-+$//g' | sed -E 's/^-+//g' | sed -E 's/-+$//g' | tr A-Z a-z)

# Create usr pkg and install
$ITFOLDER/bin/pycreateuserpkg/createuserpkg -n $USRSHORTNAME -u "$USRID" -p "$USRPASSWORD" -f "$USRFULLNAME" -a -V 1.0 -i fr.pixelis.$USRID.$USRSHORTNAME "$CUSTOMTMP/$USRID_$USRSHORTNAME.pkg"
sleep 1
/usr/sbin/installer -dumplog -verbose -pkg "$CUSTOMTMP/$USRID_$USRSHORTNAME.pkg" -target /

exit 0
