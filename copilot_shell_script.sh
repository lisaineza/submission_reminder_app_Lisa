#!/bin/bash

# Insert new assignment name
read -p "Input new assignment name: " new_assignment

# Base Directory
dir=$(find . -maxdepth 1 -type d -name "submission_reminder_*" | head -n 1)

# Check if Dir exists
if [[ ! -d "$dir" ]]; then
    echo " Error * can't locate submission_reminder_directory."
    exit 1
fi

# Update ASSIGNMENT in config.env
sed -i "s/^ASSIGNMENT=.*/ASSIGNMENT=\"$new_assignment\"/" "$dir/config/config.env"

echo "Updating the new assignment to \"$new_assignment\" in config.env"

# Run startup.sh from the $basedir
echo " Reminder check initiated for the updated assignment"
bash "$dir/startup.sh"
