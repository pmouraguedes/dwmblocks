#!/bin/sh
# File: ~/scripts/intel_gpu_status.sh

# Check for dependencies
if ! command -v jq >/dev/null || ! command -v intel_gpu_top >/dev/null || ! command -v sensors >/dev/null; then
    echo "GPU: ERR"
    exit 1
fi

# integrated GPU (Intel)

# Get GPU usage (Render/3D busy) from intel_gpu_top, run for 1 second
# Use head -n 1 to pick the first JSON object from the array
# sudo timeout 1s intel_gpu_top -s -1 -J | grep -v '^\[' | jq '.engines["Render/3D"].busy'
usage=$(sudo timeout 1s intel_gpu_top -s -1 -J 2>/dev/null | grep -v '^\[' | jq '.engines["Render/3D"].busy')

# Format output to match CPU block style (e.g., "CPU: 20% 45°C")
if [ -n "$usage" ] && [ "$usage" != "N/A" ]; then
    printf "GPU: %.0f%%\n" "$usage"
else
    echo "GPU: N/A"
fi
