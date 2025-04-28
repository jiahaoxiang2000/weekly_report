#!/bin/bash

# Define the time period for the diff (default: 6 days ago)
DAYS_AGO=${1:-5}
TIME_PERIOD="@{$DAYS_AGO days ago}"

# Make sure the delta directory exists
cd ..
mkdir -p delta


if [ -d "paper/ThirdPaper" ]; then
  cd paper/ThirdPaper
  FROM_COMMIT=$(git rev-list -1 --before="$DAYS_AGO days ago" HEAD)
  TO_COMMIT=$(git rev-parse HEAD)
  echo "Diffing ThirdPaper from $FROM_COMMIT to $TO_COMMIT"
  git diff "$FROM_COMMIT" "$TO_COMMIT" > ../../delta/thirdpaper_changes.diff
  if [ ! -s ../../delta/thirdpaper_changes.diff ]; then
    echo "No changes found in this period." > ../../delta/thirdpaper_changes.diff
  fi
  cd ../..
fi

if [ -d "paper/ThirdPaper/sphincs-plus" ]; then
  cd paper/ThirdPaper/sphincs-plus
  FROM_COMMIT=$(git rev-list -1 --before="$DAYS_AGO days ago" HEAD)
  TO_COMMIT=$(git rev-parse HEAD)
  echo "Diffing sphincs-plus from $FROM_COMMIT to $TO_COMMIT"
  git diff "$FROM_COMMIT" "$TO_COMMIT" > ../../../delta/sphincsplus_changes.diff
  if [ ! -s ../../../delta/sphincsplus_changes.diff ]; then
    echo "No changes found in this period." > ../../../delta/sphincsplus_changes.diff
  fi
  cd ../../..
fi

echo "Git diff files for the last $DAYS_AGO days have been saved to the ../delta directory."
