#!/bin/bash

# Ultimate TUW Services iOS Module Cache Fix Script
# This script completely resets and fixes all iOS module cache issues

echo "🔧 Ultimate TUW Services iOS Fix Script"
echo "======================================="

# Function to completely reset module cache
reset_module_cache() {
    echo "🧹 Performing complete module cache reset..."
    
    # Remove existing module cache completely
    rm -rf ~/Library/Developer/Xcode/DerivedData/ModuleCache.noindex
    
    # Remove all Xcode derived data for this project
    rm -rf ~/Library/Developer/Xcode/DerivedData/Runner-*
    
    # Remove temporary build directories
    rm -rf /tmp/xcode_build_*
    
    echo "✅ All caches cleared"
}

# Function to extract directory from error message
extract_directory_from_error() {
    local error_message="$1"
    echo "$error_message" | grep -o 'ModuleCache\.noindex/[^/]*' | cut -d'/' -f2 | head -1
}

# Function to create directory from error message
create_directory_from_error() {
    local error_message="$1"
    local dir_name=$(extract_directory_from_error "$error_message")

    if [ -n "$dir_name" ]; then
        mkdir -p ~/Library/Developer/Xcode/DerivedData/ModuleCache.noindex/$dir_name
        echo "✅ Created directory from error: $dir_name"
        return 0
    else
        echo "❌ Could not extract directory from error message"
        return 1
    fi
}

# Function to create fresh module cache structure
create_fresh_cache() {
    echo "📁 Creating fresh module cache structure..."
    
    # Create base directory
    mkdir -p ~/Library/Developer/Xcode/DerivedData/ModuleCache.noindex
    
    # Create Session.modulevalidation
    touch ~/Library/Developer/Xcode/DerivedData/ModuleCache.noindex/Session.modulevalidation
    
    # Create all known problematic directories
    local dirs=(
        "1CL3H2PGYUAC7"  # CoreMedia
        "1X9AJKXWMUIT5"  # sys_resource
        "2V5BH37492LF8"  # CoreImage
        "2B4W9D1ZCSXVS"  # _Builtin_intrinsics
        "1WW8UJLQCG5QJ"  # CFNetwork/UIKit
        "1VCYYLR47LO07"  # IOSurface
        "1TTSHFOBX977W"  # UIKit/AudioSession
    )
    
    for dir in "${dirs[@]}"; do
        mkdir -p ~/Library/Developer/Xcode/DerivedData/ModuleCache.noindex/$dir
        echo "✅ Created: $dir"
    done
    
    echo "✅ Fresh module cache structure created"
}

# Function to build and install iOS app
build_and_install() {
    echo "🏗️  Building and installing iOS app..."
    
    cd ios
    
    # Generate unique build path
    local build_path="/tmp/xcode_build_$(date +%s)"
    
    # Build the app
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
        local install_result=$?
        
        if [ $install_result -eq 0 ]; then
            echo "✅ App installed successfully!"
            
            # Launch app
            local process_id=$(xcrun simctl launch "A0364878-D0AC-4BC7-A30A-65AD8552FF42" com.tuwconnect.servises | cut -d' ' -f2)
            echo "🎉 App launched successfully! Process ID: $process_id"
            
            # Open simulator
            open -a Simulator
            
            return 0
        else
            echo "❌ App installation failed"
            return 1
        fi
    else
        echo "❌ Build failed with exit code: $build_result"
        return 1
    fi
}

# Main execution
echo "🚀 Starting Ultimate iOS Fix Process..."

# Step 1: Complete reset
reset_module_cache

# Step 2: Create fresh structure
create_fresh_cache

# Step 3: Build and install
build_and_install

echo ""
echo "🎯 Ultimate iOS Fix completed!"
echo "Your TUW Services app should now be running on the simulator."
