#!/bin/sh
# US market (NYSE/NASDAQ) regular session hours in local time

# Use today's NY date so DST on either side is handled correctly.
ny_day=$(TZ=America/New_York date +%F)

open=$(date -d "TZ=\"America/New_York\" ${ny_day} 09:30" +%H:%M 2>/dev/null)
close=$(date -d "TZ=\"America/New_York\" ${ny_day} 16:00" +%H:%M 2>/dev/null)

if [ -z "$open" ] || [ -z "$close" ]; then
    echo "US: err"
    exit 1
fi

now=$(TZ=America/New_York date +%H:%M)

echo "US: ${open}-${close} (${now})"
