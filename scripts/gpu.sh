#!/bin/sh
# File: ~/scripts/intel_gpu_status.sh

# Check for dependencies
if ! command -v jq >/dev/null || ! command -v intel_gpu_top >/dev/null || ! command -v sensors >/dev/null; then
    echo "iGPU: ERR"
    exit 1
fi

# integrated GPU (Intel)

# Get GPU usage (Render/3D busy) from intel_gpu_top, run for 1 second
# Use head -n 1 to pick the first JSON object from the array
# sudo timeout 1s intel_gpu_top -s -1 -J | grep -v '^\[' | jq '.engines["Render/3D"].busy'
usage=$(sudo timeout 1s intel_gpu_top -s -1 -J 2>/dev/null | grep -v '^\[' | jq '.engines["Render/3D"].busy')

# Format output to match CPU block style (e.g., "CPU: 20% 45°C")
if [ -n "$usage" ] && [ "$usage" != "N/A" ]; then
    printf "iGPU: %.0f%%\n" "$usage"
else
    echo "iGPU: N/A"
fi

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
