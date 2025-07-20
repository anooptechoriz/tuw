#!/bin/bash

# Script to replace flutter_gen imports with correct relative paths

echo "Fixing localization imports..."

# Function to calculate relative path from a file to lib/l10n/app_localizations.dart
fix_import_for_file() {
    local file="$1"
    local dir=$(dirname "$file")
    local relative_path=""

    # Calculate how many levels deep we are from lib/
    local depth=$(echo "$dir" | sed 's|lib||' | tr -cd '/' | wc -c)

    # Build the relative path
    for ((i=0; i<depth; i++)); do
        relative_path="../$relative_path"
    done

    # Add the path to the localization file
    relative_path="${relative_path}l10n/app_localizations.dart"

    # Replace the import
    sed -i '' "s|../l10n/app_localizations.dart|$relative_path|g" "$file"
    echo "Fixed: $file -> $relative_path"
}

# Find all Dart files with the wrong import and fix them
find lib -name "*.dart" -type f -exec grep -l "../l10n/app_localizations.dart" {} \; | while read file; do
    fix_import_for_file "$file"
done

echo "Import fixes completed!"
