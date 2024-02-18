#!/bin/bash

echo "---------- Merge Start ----------"
# The input file containing the indicators
input_file="main.py"
echo "Input file: $input_file"

# The resulting output file
output_file="merged.py"
echo "Output file: $output_file"

# Prepare an empty output file
: > "$output_file"

# Read the input file line by line
while IFS= read -r line || [[ -n "$line" ]]; do
  # Search for lines containing the indicator pattern
  if [[ $line =~ \<\!--\*\!\{(.*)\}--\> ]]; then
    # Extract the file path from the indicator
    file_path="${BASH_REMATCH[1]}"
    echo "✓ - File found: $file_path"
    # Check if the specified file exists
    if [ -f "$file_path" ]; then
      # Substitute the indicator line with the content of the specified file
      # Directly appending the content to the output file
      cat "$file_path" >> "$output_file"
    else
      echo "x - File not found: $file_path"
    fi
  else
    # For lines without indicators, simply add them to the output file
    echo "$line" >> "$output_file"
  fi
done < "$input_file"

# Generating the jupyter notebook from the merged file

jupytext --set-formats py:percent,ipynb "$output_file"
echo "✓ - Jupyter notebook generated"

echo "---------- Merge Complete ----------"
