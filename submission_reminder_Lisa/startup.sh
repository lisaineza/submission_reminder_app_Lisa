#!/bin/bash
cd "$(dirname "$0")"

source ./config/config.env
source ./modules/functions.sh

submissions_file="./assets/submissions.txt"

echo "Please wait ..."


# Check for Error
if [[ ! -f "$submissions_file" ]]; then
	    echo " Submitted file is NOT FOUND in  $submissions_file"
	        exit 1
fi
check_submissions $submissions_file
