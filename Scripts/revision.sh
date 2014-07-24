#!/bin/bash
NOW=$(date +"%d-%m-%y")
sudo defaults write /Library/Preferences/com.apple.loginwindow LoginwindowText "Rev" $NOW
exit 0