#!/bin/bash

# Check if target directory is provided
if [ $# -eq 0 ]; then
    echo "Error: Please provide the target project directory"
    echo "Usage: ./apply-rules.sh <target-project-directory>"
    exit 1
fi

TARGET_DIR="$1"

# Create target directory if it doesn't exist
if [ ! -d "$TARGET_DIR" ]; then
    echo "📁 Creating new project directory: $TARGET_DIR"
    mkdir -p "$TARGET_DIR"
    
    # Initialize readme for new project
    cat > "$TARGET_DIR/README.md" << 'EOL'
# New Project

This project has been initialized with agile workflow support and auto rule generation configured from [roo-auto-rules-agile-workflow](https://github.com/bmadcode/roo-auto-rules-agile-workflow).

For workflow documentation, see [Workflow Rules](docs/workflow-rules.md).
EOL
fi

# Create .roo directory if it doesn't exist
mkdir -p "$TARGET_DIR/.roo"

# Function to copy files only if they don't exist in target
copy_if_not_exists() {
    local src="$1"
    local dest="$2"
    
    if [ ! -e "$dest" ]; then
        echo "📦 Copying new file: $(basename "$dest")"
        cp "$src" "$dest"
    else
        echo "⏭️  Skipping existing file: $(basename "$dest")"
    fi
}

# Copy all files from .roo directory structure
echo "📦 Copying .roo directory files..."
find .roo -type f | while read -r file; do
    # Get the relative path from .roo
    rel_path="${file#.roo/}"
    target_file="$TARGET_DIR/.roo/$rel_path"
    target_dir="$(dirname "$target_file")"
    
    # Create target directory if it doesn't exist
    mkdir -p "$target_dir"
    
    # Copy file if it doesn't exist
    copy_if_not_exists "$file" "$target_file"
done

# Create docs directory if it doesn't exist
mkdir -p "$TARGET_DIR/docs"

# Create workflow documentation
cat > "$TARGET_DIR/docs/workflow-rules.md" << 'EOL'
# Roo Workflow Rules

This project has been updated to use the auto rule generator from [roo-auto-rules-agile-workflow](https://github.com/bmadcode/roo-auto-rules-agile-workflow).

> **Note**: This script can be safely re-run at any time to update the template rules to their latest versions. It will not impact or overwrite any custom rules you've created.

## Core Features

- Automated rule generation
- Standardized documentation formats
- Supports all 4 Note Types automatically
- AI behavior control and optimization
- Flexible workflow integration options

## Getting Started

1. Review the templates in \`xnotes/\`
2. Choose your preferred workflow approach
3. Start using the AI with confidence!

For demos and tutorials, visit: [BMad Code Videos](https://youtube.com/bmadcode)
EOL

# Update .gitignore if needed
if [ -f "$TARGET_DIR/.gitignore" ]; then
    if ! grep -q "\.roo/rules/_\*\.mdc" "$TARGET_DIR/.gitignore"; then
        echo -e "\n# Private individual user roo rules\n.roo/rules/_*.mdc" >> "$TARGET_DIR/.gitignore"
    fi
else
    echo -e "# Private individual user roo rules\n.roo/rules/_*.mdc" > "$TARGET_DIR/.gitignore"
fi

# Create xnotes directory and copy files
echo "📝 Setting up samples xnotes..."
mkdir -p "$TARGET_DIR/xnotes"
cp -r xnotes/* "$TARGET_DIR/xnotes/"

# Update .rooignore if needed
if [ -f "$TARGET_DIR/.rooignore" ]; then
    if ! grep -q "^xnotes/" "$TARGET_DIR/.rooignore"; then
        echo -e "\n# Project notes and templates\nxnotes/" >> "$TARGET_DIR/.rooignore"
    fi
else
    echo -e "# Project notes and templates\nxnotes/" > "$TARGET_DIR/.rooignore"
fi

# Create or update .rooindexingignore
if [ -f "$TARGET_DIR/.rooindexingignore" ]; then
    # Backup the original file before modifying
    cp "$TARGET_DIR/.rooindexingignore" "$TARGET_DIR/.rooindexingignore.bak"
    
    # Copy all entries from the source .rooindexingignore to the target
    cp ".rooindexingignore" "$TARGET_DIR/.rooindexingignore"
    
    echo "🔄 Updated .rooindexingignore with all entries from source"
else
    # Create new file by copying the current one
    cp ".rooindexingignore" "$TARGET_DIR/.rooindexingignore"
    echo "📝 Created new .rooindexingignore file"
fi

echo "✨ Deployment Complete!"
echo "📁 Core rule generator: $TARGET_DIR/.roo/rules/core-rules/rule-generating-agent.mdc"
echo "📁 Sample subfolders and rules: $TARGET_DIR/.roo/rules/{sub-folders}/"
echo "📁 Sample Agile Workflow Templates: $TARGET_DIR/.roo/templates/"
echo "📄 Workflow Documentation: $TARGET_DIR/docs/workflow-rules.md"
echo "🔒 Updated .gitignore, .rooignore, and .rooindexingignore"
