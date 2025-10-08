#!/bin/sh

# external GPU (AMD)

card="card0"

# Get GPU usage
if [ -r "/sys/class/drm/$card/device/gpu_busy_percent" ]; then
    usage=$(cat "/sys/class/drm/$card/device/gpu_busy_percent")
else
    usage="N/A"
fi

# Format output to match CPU/iGPU style (e.g., "CPU: 20% 45°C")
if [ "$usage" != "N/A" ]; then
    printf "eGPU: %s%%\n" "$usage"
else
    echo "eGPU: N/A"
fi
