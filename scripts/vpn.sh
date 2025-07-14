#!/bin/bash

# Check if ppp0 interface exists (indicating VPN is connected)
if ip link show ppp0 &>/dev/null; then
    echo "🔒" # VPN connected icon
else
    echo "🔓" # VPN disconnected icon
fi
