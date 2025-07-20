#!/bin/bash

# Script to automatically fix all namespace issues in Flutter plugins

echo "Finding and fixing all namespace issues..."

PUB_CACHE="/Users/techoriz/.pub-cache/hosted/pub.dev"

# Function to add namespace to a build.gradle file
fix_namespace() {
    local build_file="$1"
    local namespace="$2"
    
    if [ -f "$build_file" ]; then
        echo "Fixing: $build_file with namespace: $namespace"
        # Check if namespace already exists
        if ! grep -q "namespace" "$build_file"; then
            # Backup the original file
            cp "$build_file" "$build_file.backup" 2>/dev/null
            
            # Add namespace after 'android {' line
            sed -i '' "/^android {/a\\
    namespace '$namespace'
" "$build_file"
            echo "✓ Added namespace to $build_file"
        else
            echo "✓ Namespace already exists in $build_file"
        fi
    fi
}

# Fix all known problematic plugins
fix_namespace "$PUB_CACHE/device_info-2.0.3/android/build.gradle" "io.flutter.plugins.deviceinfo"
fix_namespace "$PUB_CACHE/flutter_keyboard_visibility-5.4.1/android/build.gradle" "com.jrai.flutter_keyboard_visibility"
fix_namespace "$PUB_CACHE/maps_launcher-2.2.1/android/build.gradle" "com.example.maps_launcher"
fix_namespace "$PUB_CACHE/platform_device_id-1.0.1/android/build.gradle" "com.example.platform_device_id"
fix_namespace "$PUB_CACHE/url_launcher_android-6.2.0/android/build.gradle" "io.flutter.plugins.urllauncher"

# Find and fix other plugins that might exist
for plugin_dir in "$PUB_CACHE"/*; do
    if [ -d "$plugin_dir/android" ] && [ -f "$plugin_dir/android/build.gradle" ]; then
        plugin_name=$(basename "$plugin_dir")
        build_file="$plugin_dir/android/build.gradle"
        
        # Skip if already processed
        if grep -q "namespace" "$build_file"; then
            continue
        fi
        
        # Generate a reasonable namespace based on plugin name
        namespace="com.example.$(echo "$plugin_name" | sed 's/-/_/g' | sed 's/[0-9.]*$//')"
        
        echo "Auto-fixing: $plugin_name"
        fix_namespace "$build_file" "$namespace"
    fi
done

echo "All namespace fixes completed!"
