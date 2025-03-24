#!/bin/bash

# Define the time period for the diff (default: 6 days ago)
DAYS_AGO=${1:-5}
TIME_PERIOD="@{$DAYS_AGO days ago}"

# Make sure the delta directory exists
cd ..
mkdir -p delta

# Generate a diff between the specified time period and current HEAD
# Save it to a file in the delta directory
git diff "$TIME_PERIOD" HEAD > delta/recent_changes.diff

if [ -d "paper/ThirdPaper" ]; then
  cd paper/ThirdPaper
  git diff "$TIME_PERIOD" HEAD > ../../delta/thirdpaper_changes.diff
  cd ../..
fi

# also have the paper/ThirdPaper/sphincs-plus folder
if [ -d "paper/ThirdPaper/sphincs-plus" ]; then
  cd paper/ThirdPaper/sphincs-plus
  git diff "$TIME_PERIOD" HEAD > ../../../delta/sphincsplus_changes.diff
  cd ../../..
fi

echo "Git diff files for the last $DAYS_AGO days have been saved to the ../delta directory."
