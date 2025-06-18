#!/bin/bash

# Get the connected Wi-Fi service (lines starting with * and containing wifi_)
SERVICE=$(connmanctl services | grep -E "^\*" | grep wifi_ | awk '{print $3}')

if [ -z "$SERVICE" ]; then
    echo "󰈀 "
    exit 1
fi

# Get signal strength (ConnMan reports it as a percentage directly)
SIGNAL=$(connmanctl services "$SERVICE" | grep Strength | awk '{print $3}')

if [ -n "$SIGNAL" ]; then
    # ConnMan's Strength is already a percentage (0-100)
    echo "   ${SIGNAL}%"
else
    echo "Unable to retrieve signal strength"
    exit 1
fi
