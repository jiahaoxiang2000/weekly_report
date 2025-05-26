#!/bin/bash

# Function to show help information
show_help() {
    echo "Usage: $0 [DAYS_AGO] [FOLDER_NAME1] [FOLDER_NAME2] ..."
    echo ""
    echo "Generate git diff files for the specified folder(s) within a time period."
    echo ""
    echo "Arguments:"
    echo "  DAYS_AGO        Number of days ago to start the diff from (default: 5)"
    echo "  FOLDER_NAME(S)  Name(s) of the folder(s) to diff (default: ThirdPaper)"
    echo "                  Available options: any folder in the workspace (paper/, typesetting/, etc.)"
    echo "                  You can specify multiple folders separated by spaces"
    echo "                  Use 'all' to diff all git repositories in the workspace"
    echo "                  Use 'paper' to diff all folders in paper/ directory only"
    echo ""
    echo "Examples:"
    echo "  $0                              # Diff paper/ThirdPaper for last 5 days"
    echo "  $0 7                            # Diff paper/ThirdPaper for last 7 days"
    echo "  $0 3 paper/FourthPaper          # Diff paper/FourthPaper for last 3 days"
    echo "  $0 5 paper/ThirdPaper paper/FourthPaper  # Diff both papers for last 5 days"
    echo "  $0 5 typesetting                # Diff typesetting folder for last 5 days"
    echo ""
    echo "Output files will be saved to the delta directory."
    exit 0
}

# Check for help flag
if [[ "$1" == "-h" || "$1" == "--help" ]]; then
    show_help
fi

# Define the time period for the diff (default: 5 days ago)
DAYS_AGO=${1:-5}

# Validate DAYS_AGO is a number
if ! [[ "$DAYS_AGO" =~ ^[0-9]+$ ]]; then
    echo "Error: DAYS_AGO must be a positive number."
    echo ""
    show_help
fi

# Get folder names from remaining arguments
shift # Remove the first argument (DAYS_AGO)
FOLDER_NAMES=("$@")

# Determine the base directory (where delta should be created)
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BASE_DIR="$(dirname "$SCRIPT_DIR")"

# Make sure the delta directory exists
cd "$BASE_DIR"
mkdir -p delta

# Function to generate diff for a single folder
generate_folder_diff() {
    local folder_name=$1
    local days_ago=$2
    
    # Check if the specified folder exists
    if [ ! -d "$folder_name" ]; then
        echo "Warning: Folder '$folder_name' does not exist. Skipping..."
        return 1
    fi
    
    # Check if it's a git repository (including submodules)
    if [ ! -d "$folder_name/.git" ] && [ ! -f "$folder_name/.git" ]; then
        echo "Warning: '$folder_name' is not a git repository. Skipping..."
        return 1
    fi
    
    echo "Processing folder: $folder_name"
    
    # Generate diff for the folder
    cd "$folder_name"
    FROM_COMMIT=$(git rev-list -1 --before="$days_ago days ago" HEAD)
    TO_COMMIT=$(git rev-parse HEAD)
    
    # Check if we found a valid commit
    if [ -z "$FROM_COMMIT" ]; then
        echo "Warning: No commit found from $days_ago days ago for $folder_name. Using first commit."
        FROM_COMMIT=$(git rev-list --max-parents=0 HEAD)
    fi
    
    echo "  Diffing $folder_name from $FROM_COMMIT to $TO_COMMIT"
    
    # Create filename for the diff (replace slashes with underscores)
    DIFF_NAME=$(echo "$folder_name" | tr '/' '_' | tr '[:upper:]' '[:lower:]')
    
    # Store diff in the delta directory (relative to BASE_DIR)
    git diff "$FROM_COMMIT" "$TO_COMMIT" > "$BASE_DIR/delta/${DIFF_NAME}_changes.diff"
    
    if [ ! -s "$BASE_DIR/delta/${DIFF_NAME}_changes.diff" ]; then
        echo "  No changes found in this period." > "$BASE_DIR/delta/${DIFF_NAME}_changes.diff"
    fi
    cd - > /dev/null
    
    return 0
}

# Process all specified folders
processed_folders=()
failed_folders=()

echo "Starting git diff generation for ${#FOLDER_NAMES[@]} folder(s)..."
echo ""

for folder_name in "${FOLDER_NAMES[@]}"; do
    if generate_folder_diff "$folder_name" "$DAYS_AGO"; then
        processed_folders+=("$folder_name")
    else
        failed_folders+=("$folder_name")
    fi
    echo ""
done

# Summary
echo "=== Summary ==="
echo "Git diff files for the last $DAYS_AGO days have been saved to the delta directory."

if [ ${#processed_folders[@]} -gt 0 ]; then
    echo "Successfully processed folders: ${processed_folders[*]}"
fi

if [ ${#failed_folders[@]} -gt 0 ]; then
    echo "Failed to process folders: ${failed_folders[*]}"
fi
