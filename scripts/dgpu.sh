#!/bin/sh

# discrete GPU (NVIDIA)

if ! command -v nvidia-smi >/dev/null; then
    echo "GPU: ERR"
    exit 1
fi

usage=$(nvidia-smi --query-gpu=utilization.gpu --format=csv,noheader,nounits 2>/dev/null | head -n 1)

# Format output to match CPU block style (e.g., "CPU: 20% 45°C")
if [ -n "$usage" ]; then
    printf "GPU: %s%%\n" "$usage"
else
    echo "GPU: N/A"
fi
