#!/bin/sh
# dwmblocks sunrise/sunset exact time

# Coordinates
LAT="38.7071"
LON="-9.1359"

# Fetch data
data=$(curl -s --connect-timeout 8 "https://api.sunrise-sunset.org/json?lat=${LAT}&lng=${LON}&formatted=0")

if [ -z "$data" ] || echo "$data" | grep -q "INVALID_REQUEST"; then
    echo "󰖜/󰖛 err"
    exit 1
fi

# Keep the offset so date treats these as absolute instants, not local wall time.
sunrise_iso=$(echo "$data" | grep -oP '(?<="sunrise":")[^"]+')
sunset_iso=$(echo "$data" | grep -oP '(?<="sunset":")[^"]+')

# System zone is not Lisbon (often Europe/Berlin). Force WET/WEST explicitly.
sunrise=$(TZ=Europe/Lisbon date -d "${sunrise_iso}" +%H:%M 2>/dev/null)
sunset=$(TZ=Europe/Lisbon date -d "${sunset_iso}" +%H:%M 2>/dev/null)

if [ -z "$sunrise" ] || [ -z "$sunset" ]; then
    echo "󰖜/󰖛 err  "
    exit 1
fi

# Output with your icons (you can add colors via ^c#hex^ if your dwmblocks supports pango/escape codes)
echo " ${sunrise}  ${sunset}"
