#!/bin/bash
# Find all files under tests/acceptance that contain the regex pattern
# Using an array is safer, especially if you ever have files with spaces
readarray -t FILES < <(grep -Erl 'adminDataset/(update|create)' tests/acceptance)

# Check if any files were found
if [ ${#FILES[@]} -eq 0 ]; then
  echo "No test files found matching the pattern 'adminDataset/(update|create)'."
  exit 0
fi

echo "Found ${#FILES[@]} matching files. Running tests serially..."
echo "---"

# Loop through each file found and run the test command for it
for FILE in "${FILES[@]}"; do
  echo "▶️ Running test: $FILE"
  docker-compose run --rm codecept run --no-redirect acceptance "$FILE"
  echo "---"
done

echo "✅ All matching tests completed."