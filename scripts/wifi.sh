#!/bin/bash

ETHERNET_INTERFACE="enp0s31f6"
WIFI_INTERFACE="wlp0s20f3"

[ "$(cat /sys/class/net/$ETHERNET_INTERFACE/operstate)" = 'up' ] && ethernet=up
[ "$(cat /sys/class/net/$WIFI_INTERFACE/operstate)" = 'up' ] && wifi=up

output=""

if [ "$ethernet" = "up" ]; then
    output="${output}󰈀"
fi
if [ "$wifi" = "up" ]; then
    output="${output}  "

    percent="$(iw dev wlp0s20f3 link |
        sed -n '/signal/s/.*\(-[0-9]*\).*/\1/p' |
        awk '{print ($1 > -50 ? 100 :($1 < -100 ? 0 : ($1+100)*2))}')"
    output="${output}${percent}%"
else
    output="No Internet"
fi

echo "$output"
