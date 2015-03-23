#!/bin/sh

SSID=MY_COOL_SSID
PASSWORD=MY_STRONG_PASSWORD

sudo /usr/sbin/networksetup -addpreferredwirelessnetworkatindex en0 "$SSID" 0 WPA2 "$PASSWORD"
sudo /usr/sbin/networksetup -addpreferredwirelessnetworkatindex en1 "$SSID" 0 WPA2 "$PASSWORD"

exit 0
