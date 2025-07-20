#!/bin/bash

# Script to fix namespace issues in Flutter plugins for Android Gradle Plugin 8.0+

echo "Fixing namespace issues in Flutter plugins..."

# Function to add namespace to a build.gradle file
add_namespace() {
    local build_file="$1"
    local namespace="$2"
    
    if [ -f "$build_file" ]; then
        echo "Processing: $build_file"
        # Backup the original file
        cp "$build_file" "$build_file.backup"
        
        # Add namespace after 'android {' line
        sed -i '' "/^android {/a\\
    namespace '$namespace'
" "$build_file"
        
        echo "Added namespace '$namespace' to $build_file"
    else
        echo "File not found: $build_file"
    fi
}

# List of plugins that need namespace fixes
PUB_CACHE="/Users/techoriz/.pub-cache/hosted/pub.dev"

# Fix device_info
add_namespace "$PUB_CACHE/device_info-2.0.3/android/build.gradle" "io.flutter.plugins.deviceinfo"

# Fix flutter_keyboard_visibility
add_namespace "$PUB_CACHE/flutter_keyboard_visibility-5.4.1/android/build.gradle" "com.jrai.flutter_keyboard_visibility"

# Fix maps_launcher
add_namespace "$PUB_CACHE/maps_launcher-2.2.1/android/build.gradle" "com.example.maps_launcher"

# Fix url_launcher
add_namespace "$PUB_CACHE/url_launcher_android-6.3.10/android/build.gradle" "io.flutter.plugins.urllauncher"

# Fix path_provider
add_namespace "$PUB_CACHE/path_provider_android-2.2.10/android/build.gradle" "io.flutter.plugins.pathprovider"

# Fix shared_preferences
add_namespace "$PUB_CACHE/shared_preferences_android-2.3.3/android/build.gradle" "io.flutter.plugins.sharedpreferences"

# Fix permission_handler
add_namespace "$PUB_CACHE/permission_handler_android-12.0.12/android/build.gradle" "com.baseflow.permissionhandler"

# Fix geolocator
add_namespace "$PUB_CACHE/geolocator_android-4.6.1/android/build.gradle" "com.baseflow.geolocator"

# Fix audioplayers
add_namespace "$PUB_CACHE/audioplayers_android-4.0.3/android/build.gradle" "xyz.luan.audioplayers"

# Fix vibration
add_namespace "$PUB_CACHE/vibration-1.9.0/android/build.gradle" "io.flutter.plugins.vibration"

# Fix image_picker
add_namespace "$PUB_CACHE/image_picker_android-0.8.12+13/android/build.gradle" "io.flutter.plugins.imagepicker"

# Fix google_maps_flutter
add_namespace "$PUB_CACHE/google_maps_flutter_android-2.14.7/android/build.gradle" "io.flutter.plugins.googlemaps"

echo "Namespace fixes completed!"
