#!/bin/bash


quote() {
    local quotes_file="$HOME/dotfiles/quotes.csv"
    
    # Check if file exists
    if [ ! -f "$quotes_file" ]; then
        echo "Error: File '$quotes_file' not found" >&2
        return 1
    fi
    
    # Count the number of lines in the file
    local line_count=$(wc -l < "$quotes_file")

    # Pick a random line number
    local random_line=$((RANDOM % line_count + 1))
    
    # Get the random quote using sed
    local quote_line=$(sed -n "${random_line}p" "$quotes_file")
    
    # Extract the author and quote using awk
    # This handles the CSV format and properly accounts for commas inside quoted fields
    local author=$(echo "$quote_line" | awk -F'",' '{print $1}' | sed 's/^"//')
    local quote=$(echo "$quote_line" | awk -F'",' '{print $2}' | sed 's/^"//' | sed 's/"$//')
    
    # Handle empty author field
    if [ -z "$author" ]; then
        author="Unknown"
    fi
    
    # Return the formatted quote
    printf "\"$quote\", - $author"
}

