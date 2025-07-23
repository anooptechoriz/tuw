#!/bin/bash

# TUW Services iOS Module Cache Fix Script
# This script automatically fixes iOS module cache errors by creating missing directories

echo "🔧 TUW Services iOS Module Cache Fix Script"
echo "==========================================="

# Function to extract directory name from error message
extract_directory_from_error() {
    local error_message="$1"
    # Extract directory name between ModuleCache.noindex/ and the next /
    echo "$error_message" | grep -o 'ModuleCache\.noindex/[^/]*' | cut -d'/' -f2
}

# Function to create module cache directory
create_module_cache_dir() {
    local dir_name="$1"
    local full_path="$HOME/Library/Developer/Xcode/DerivedData/ModuleCache.noindex/$dir_name"
    
    echo "📁 Creating module cache directory: $dir_name"
    mkdir -p "$full_path"
    
    if [ -d "$full_path" ]; then
        echo "✅ Successfully created: $full_path"
        return 0
    else
        echo "❌ Failed to create: $full_path"
        return 1
    fi
}

# Function to build iOS app
build_ios_app() {
    echo "🏗️  Building iOS app..."
    cd ios
    
    # Generate unique build path
    local build_path="/tmp/xcode_build_$(date +%s)"
    
    xcodebuild -workspace Runner.xcworkspace \
               -scheme Runner \
               -configuration Debug \
               -destination 'platform=iOS Simulator,name=iPhone 16 Pro Max Fixed' \
               -derivedDataPath "$build_path" \
               clean build
    
    local build_result=$?
    
    if [ $build_result -eq 0 ]; then
        echo "✅ Build succeeded!"
        echo "📱 Installing app to simulator..."
        
        # Install and launch app
        xcrun simctl install "A0364878-D0AC-4BC7-A30A-65AD8552FF42" "$build_path/Build/Products/Debug-iphonesimulator/Runner.app"
        xcrun simctl launch "A0364878-D0AC-4BC7-A30A-65AD8552FF42" com.tuwconnect.servises
        
        echo "🎉 App successfully launched!"
        return 0
    else
        echo "❌ Build failed with exit code: $build_result"
        return 1
    fi
}

# Function to completely reset module cache
reset_module_cache() {
    echo "🧹 Performing complete module cache reset..."

    # Remove existing module cache
    rm -rf ~/Library/Developer/Xcode/DerivedData/ModuleCache.noindex

    # Recreate base directory
    mkdir -p ~/Library/Developer/Xcode/DerivedData/ModuleCache.noindex

    # Create Session.modulevalidation
    touch ~/Library/Developer/Xcode/DerivedData/ModuleCache.noindex/Session.modulevalidation

    echo "✅ Module cache completely reset"
}

# Main execution
echo "🚀 Starting iOS build process..."

# Option to do complete reset if needed
if [ "$1" = "--reset" ]; then
    reset_module_cache
fi

# Common module cache directories that often cause issues
COMMON_DIRS=(
    "1CL3H2PGYUAC7"
    "1X9AJKXWMUIT5"
    "2V5BH37492LF8"
    "2B4W9D1ZCSXVS"
    "1WW8UJLQCG5QJ"
)

echo "📁 Pre-creating common module cache directories..."
for dir in "${COMMON_DIRS[@]}"; do
    create_module_cache_dir "$dir"
done

echo "📄 Creating Session.modulevalidation file..."
mkdir -p "$HOME/Library/Developer/Xcode/DerivedData/ModuleCache.noindex"
touch "$HOME/Library/Developer/Xcode/DerivedData/ModuleCache.noindex/Session.modulevalidation"
echo "✅ Session.modulevalidation created"

# Attempt to build
build_ios_app

echo "✅ iOS Module Cache Fix Script completed!"
