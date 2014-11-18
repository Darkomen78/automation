#!/bin/bash
# Version 1.1 by Sylvain La Gravière
# Twitter : @darkomen78
# Mail : darkomen@me.com

# Determine interface number
# for all ethernet interface
for i in $(networksetup -listallhardwareports | grep -A1 '[E-e]thernet' | grep en | grep -o "[^ ]*$")
do
if [ "`ifconfig $i | grep \"status: active\"`" != "" ]; then 
ETHINT=$i
fi
done
# for Wi-Fi
AIRINT=$(networksetup -listallhardwareports | grep -A1 '[W-w]i-Fi\|[A-a]irport' | grep en | grep -o "[^ ]*$")

function set_airport {

    new_status=$1

    if [ $new_status = "On" ]; then
        /usr/sbin/networksetup -setairportpower $AIRINT on
        touch /var/tmp/prev_air_on
    else
        /usr/sbin/networksetup -setairportpower $AIRINT off
        if [ -f "/var/tmp/prev_air_on" ]; then
            rm /var/tmp/prev_air_on
        fi
    fi
}

# Set default values
prev_eth_status="Off"
prev_air_status="Off"
eth_status="Off"


# Determine previous ethernet status
# If file prev_eth_on exists, ethernet was active last time we checked
if [ -f "/var/tmp/prev_eth_on" ]; then
    prev_eth_status="On"
fi

# Determine previous thunderbolt ethernet status
# If file prev_tb_on exists, thunderbolt ethernet was active last time we checked
if [ -f "/var/tmp/prev_tb_on" ]; then
    prev_tb_status="On"
fi

# Determine previous Wi-Fi status
# File is prev_air_on
if [ -f "/var/tmp/prev_air_on" ]; then
    prev_air_status="On"
fi

# And actual current AirPort status
air_status=`/usr/sbin/networksetup -getairportpower $AIRINT | awk '{ print $4 }'`

# Check actual current ethernet status
if [[ -n $ETHINT ]]; then
if [ "`ifconfig $ETHINT | grep \"status: active\"`" != "" ]; then
    eth_status="On"
fi
fi

# Determine whether ethernet status changed
if [ "$prev_eth_status" != "$eth_status" ]; then
    if [ "$eth_status" = "On" ]; then
        set_airport "Off"
        osascript -e 'display notification "Wired network detected. Turning AirPort off." with title "Wi-Fi Toggle"'
    else
        set_airport "On"
        osascript -e 'display notification "No wired network detected. Turning AirPort on." with title "Wi-Fi Toggle"'
    fi
else
# Check whether AirPort status changed
# If so it was done manually by user
    if [ "$prev_air_status" != "$air_status" ]; then
        set_airport $air_status
        if [ "$air_status" = "On" ]; then
            osascript -e 'display notification "Wi-Fi manually turned on." with title "Wi-Fi Toggle"'
        else
            osascript -e 'display notification "Wi-Fi manually turned off." with title "Wi-Fi Toggle"'
        fi
    fi
fi

# Update ethernet status
if [ "$eth_status" == "On" ]; then
    touch /var/tmp/prev_eth_on
else
    if [ -f "/var/tmp/prev_eth_on" ]; then
        rm /var/tmp/prev_eth_on
    fi
fi
exit 0
