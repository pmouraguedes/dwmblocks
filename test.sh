#!/bin/sh
[ "$(cat /sys/class/net/wlp0s20f3/operstate)" = 'down' ] && wifi=down
wifi="${wifi:-$(iw dev wlp0s20f3 link |
    sed -n '/signal/s/.*\(-[0-9]*\).*/\1/p' |
    awk '{print ($1 > -50 ? 100 :($1 < -100 ? 0 : ($1+100)*2))}')%}"
echo "$wifi"
