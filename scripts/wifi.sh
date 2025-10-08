#!/bin/bash

# if you don't have NetworkManager (nmcli) installed, just harcode the interface names
ETHERNET_INTERFACE=$(nmcli device | grep -e 'ethernet\s' | awk '{ print $1}')
WIFI_INTERFACE=$(nmcli device | grep -e 'wifi\s' | awk '{ print $1}')

[ "$(cat /sys/class/net/"$ETHERNET_INTERFACE"/operstate)" = 'up' ] && ethernet=up
[ "$(cat /sys/class/net/"$WIFI_INTERFACE"/operstate)" = 'up' ] && wifi=up

output=""

if [ "$ethernet" = "up" ]; then
    output="${output}󰈀"
fi
if [ "$wifi" = "up" ]; then
    output="${output}   "

    percent="$(iw dev wlp0s20f3 link |
        sed -n '/signal/s/.*\(-[0-9]*\).*/\1/p' |
        awk '{print ($1 > -50 ? 100 :($1 < -100 ? 0 : ($1+100)*2))}')"
    output="${output}${percent}%"
fi
if [ "$wifi" != "up" ] && [ "$ethernet" != "up" ]; then
    output="No Internet"
fi

echo "$output"
