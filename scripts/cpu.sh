#!/bin/bash

# Read initial CPU stats from /proc/stat
read -r cpu user nice system idle iowait irq softirq steal guest guest_nice </proc/stat

# Sum initial active and total CPU times
cpu_active_prev=$((user + nice + system + irq + softirq + steal))
cpu_total_prev=$((user + nice + system + idle + iowait + irq + softirq + steal))

# Wait for a short interval to measure CPU usage
sleep 0.5

# Read new CPU stats
read -r cpu user nice system idle iowait irq softirq steal guest guest_nice </proc/stat

# Sum new active and total CPU times
cpu_active=$((user + nice + system + irq + softirq + steal))
cpu_total=$((user + nice + system + idle + iowait + irq + softirq + steal))

# Calculate differences
active_diff=$((cpu_active - cpu_active_prev))
total_diff=$((cpu_total - cpu_total_prev))

# Calculate CPU usage percentage
if [ "$total_diff" -eq 0 ]; then
    cpu_percent=0
else
    cpu_percent=$((100 * active_diff / total_diff))
fi

# Output formatted percentage
printf "%d%%\n" "$cpu_percent"
