#!/bin/bash

# Define the input CSV file
input_file="reports/baseline_model_results.csv"

# Check if the file exists
if [[ ! -f "$input_file" ]]; then
    echo "Error: File $input_file not found!"
    exit 1
fi

# Initialize variables
best_model=""
max_f1_score=0

# Read the CSV file and find the best model based on the F1-score
best_model=$(awk -F, '
    NR == 1 { next }  # Skip header line
    {
        if ($3 > max) {  # Assuming the F1-score is in the 3rd column
            max=$3;
            best=$0;  # Store the entire line of the best model
        }
    }
    END { print best }' "$input_file")

# Check if a best model was found
if [[ -n "$best_model" ]]; then
    echo "Best model based on F1-score:"
    echo "$best_model"
else
    echo "No models found in the file."
fi

