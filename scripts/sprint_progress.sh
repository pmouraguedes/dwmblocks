#!/bin/bash

# Configuration
SPRINT_WEEKS=4             # Hardcoded sprint duration in weeks
INITIAL_START="2025-06-10" # Fixed initial sprint start date (a Monday, adjust once)
# END_DAY="monday"           # Sprint ends on a Monday

# Convert dates to seconds since epoch
initial_start_seconds=$(date -d "$INITIAL_START" +%s)
current_seconds=$(date +%s)

# Calculate seconds per sprint (weeks * seconds per week)
seconds_per_sprint=$((SPRINT_WEEKS * 7 * 24 * 60 * 60))

# Calculate how many sprints have passed since INITIAL_START
sprints_passed=$(((current_seconds - initial_start_seconds) / seconds_per_sprint))

# Calculate the start and end dates of the current sprint
current_sprint_start_seconds=$((initial_start_seconds + (sprints_passed * seconds_per_sprint)))
# current_sprint_start=$(date -d "@$current_sprint_start_seconds" '+%Y-%m-%d')
current_sprint_end_seconds=$((current_sprint_start_seconds + seconds_per_sprint))
# current_sprint_end=$(date -d "@$current_sprint_end_seconds" '+%Y-%m-%d')

# Function to count weekdays between two dates (inclusive of start, exclusive of end)
count_weekdays() {
    local start=$1
    local end=$2
    local days=0
    local current=$start

    while [ $current -lt $end ]; do
        # Get day of the week (1=Monday, ..., 7=Sunday)
        day_of_week=$(date -d "@$current" +%u)
        # Count only Monday to Friday (1 to 5)
        if [ $day_of_week -le 5 ]; then
            days=$((days + 1))
        fi
        # Move to next day
        current=$((current + 86400))
    done
    echo $days
}

# Calculate total weekdays in the sprint (from start to end)
total_weekdays=$(count_weekdays $current_sprint_start_seconds $current_sprint_end_seconds)

# Calculate elapsed weekdays (from start to current date)
elapsed_weekdays=$(count_weekdays $current_sprint_start_seconds $current_seconds)

# Calculate progress percentage based on weekdays
if [ $total_weekdays -gt 0 ]; then
    progress=$(((elapsed_weekdays * 100) / total_weekdays))
else
    progress=0
fi

# Ensure progress is between 0 and 100
if [ $progress -lt 0 ]; then
    progress=0
elif [ $progress -gt 100 ]; then
    progress=100
fi

# Create a simple progress bar (20 characters wide)
bar_length=10
filled=$(((progress * bar_length) / 100))
bar=""
for ((i = 0; i < bar_length; i++)); do
    if [ $i -lt $filled ]; then
        bar="${bar}█"
    else
        bar="${bar}-"
    fi
done

# Format dates for display
# start_display=$(date -d "$current_sprint_start" '+%b %d, %Y')
# end_display=$(date -d "$current_sprint_end" '+%b %d, %Y')

# Output for dwmblocks (icon and progress)
# icon="📅"
printf "Sprint: %d%% [%s]" "$progress" "$bar"
# printf "Sprint: %d%%" "$progress"
