#!/bin/bash

# Insert username
read -p "Insert	Username: " username

# Defining the root directory
dir="submission_reminder_${username}"

# Create the tree 
mkdir -p "$dir/config"
mkdir -p "$dir/modules"
mkdir -p "$dir/app"
mkdir -p "$dir/assets"

# Add content to the config.env file
cat <<EOF > "$dir/config/config.env"
# This is the config file
ASSIGNMENT="Shell Navigation"
DAYS_REMAINING=2
EOF

# Add content to the functions.sh file
cat <<'EOF' > "$dir/modules/functions.sh"
#!/bin/bash
# Reads the submissions file and lists students who haven't submitted their work
function check_submissions {
    local submissions_file=$1
    echo "Check submissions in $submissions_file"

    # Ignore the header and process each remaining line
    while IFS=, read -r student assignment status; do
        # Delete leading and trailing whitespace
        student=$(echo "$student" | xargs)
        assignment=$(echo "$assignment" | xargs)
        status=$(echo "$status" | xargs)

        # Does assignment match and print 'not submitted'
        if [[ "$assignment" == "$ASSIGNMENT" && "$status" == "not submitted" ]]; then
            echo "Disclaimer: $student did not submit the $ASSIGNMENT assignment!"
        fi
   done < <(tail -n +2 "$submissions_file") # Skip header
}
EOF

# Add content to the reminder.sh file
cat <<'EOF' > "$dir/app/reminder.sh"
#!/bin/bash

# Source environment variables and helper functions
source ./config/config.env
source ./modules/functions.sh

# submissions file
submissions_file="./assets/submissions.txt"

# Print remaining time, run the reminder function
echo "Assignment: $ASSIGNMENT"
echo "Deadline day: $DAYS_REMAINING days"

check_submissions $submissions_file
EOF

# In the submissions.txt add 5 more students
cat <<EOF > "$dir/assets/submissions.txt"
student, assignment, submission status
Chinemerem, Shell Navigation, not submitted
Chiagoziem, Git, submitted
Divine, Shell Navigation, not submitted
Anissa, Shell Basics, submitted
Zulu, Shell Navigation, submitted
Marvin,Git, submitted
Diane, Shell Basics,not submitted
Alice, Git, not submitted
Gisingizo, Shell Navigation, submitted

EOF

# chmod  all .sh files make them executable
	find "$dir" -type f -name "*.sh" -exec chmod +x {} \;

# Statement after a successful  running
echo "Program has created in $dir successfully"
