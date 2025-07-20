#!/bin/bash

# Script to fix AndroidManifest.xml package attribute issues

echo "Fixing AndroidManifest.xml package attributes..."

PUB_CACHE="/Users/techoriz/.pub-cache/hosted/pub.dev"

# Function to remove package attribute from AndroidManifest.xml
fix_manifest() {
    local manifest_file="$1"
    
    if [ -f "$manifest_file" ]; then
        echo "Processing: $manifest_file"
        # Backup the original file
        cp "$manifest_file" "$manifest_file.backup" 2>/dev/null
        
        # Remove package attribute
        sed -i '' 's/package="[^"]*"//' "$manifest_file"
        
        echo "✓ Fixed $manifest_file"
    fi
}

# Find all AndroidManifest.xml files in pub cache and fix them
find "$PUB_CACHE" -name "AndroidManifest.xml" -path "*/android/src/main/*" | while read manifest; do
    # Check if it contains a package attribute
    if grep -q 'package="' "$manifest"; then
        fix_manifest "$manifest"
    fi
done

echo "AndroidManifest.xml fixes completed!"
