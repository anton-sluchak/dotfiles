#!/bin/bash

# This script creates symbolic links in the parent directory
# pointing to files/directories in the current directory
# with special handling for dotfiles (files starting with '.')

# install plugins
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions


IGNORED_FILES=(
    "init.sh"
    ".git"
    ".gitignore"
    "README.md"
    "quotes.csv"
    "quote.sh"
)

should_ignore() {
    local item_to_check="$1"
    
    for ignored_item in "${IGNORED_FILES[@]}"; do
        if [ "$item_to_check" = "$ignored_item" ]; then
            return 0  # True, should ignore
        fi
    done
    
    return 1  # False, should not ignore
}


# Get the parent directory path
PARENT_DIR=".."

# Check if parent directory exists and is writable
if [ ! -d "$PARENT_DIR" ]; then
    echo "Error: Parent directory '$PARENT_DIR' does not exist."
    exit 1
fi

if [ ! -w "$PARENT_DIR" ]; then
    echo "Error: Parent directory '$PARENT_DIR' is not writable."
    exit 1
fi

# Counter for statistics
links_created=0
items_skipped=0

# First, look for all regular files (including those starting with dot)
for item in * .[!.]* ..?*; do
    # Skip if the pattern doesn't match anything
    [ -e "$item" ] || continue
    
    
    if should_ignore "$item"; then
        echo "Skipping ignored file: $item"
        items_skipped=$((items_skipped + 1))
        continue
    fi


    # Get absolute path of the current item
    abs_path="$(pwd)/$item"
    
    # Target path in parent directory
    target_path="$PARENT_DIR/$item"
    
    # Check if a file with the same name already exists in parent directory
    if [ -e "$target_path" ]; then
        echo "Warning: '$target_path' already exists. Skipping."
        items_skipped=$((items_skipped + 1))
        continue
    fi
    
    # Create symbolic link in the parent directory
    ln -s "$abs_path" "$target_path"
    # echo "Would run ln -s $abs_path $target_path"
    
    if [ $? -eq 0 ]; then
        echo "Created symlink in parent directory: $target_path -> $abs_path"
        links_created=$((links_created + 1))
    else
        echo "Error creating symlink for '$item' in parent directory"
        items_skipped=$((items_skipped + 1))
    fi
done


# Install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

echo "source ~/dotfiles/.zshrc" >> ~/.zshrc

echo ""
echo "Summary:"
echo "  Links created: $links_created"
echo "  Items skipped: $items_skipped"
echo ""
echo "Note: Links were created in parent directory ($PARENT_DIR) pointing to files in current directory."

