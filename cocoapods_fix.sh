#!/bin/bash

# Comprehensive CocoaPods Fix Script for TUW Services
# Fixes broken CocoaPods installation and module cache issues

echo "🔧 Comprehensive CocoaPods Fix Script"
echo "====================================="

# Function to set correct environment
set_environment() {
    echo "🌍 Setting correct environment..."
    
    # Use Homebrew CocoaPods and disable rbenv
    export PATH="/opt/homebrew/bin:$PATH"
    unset RBENV_VERSION
    unset RBENV_ROOT
    
    echo "✅ Environment configured for Homebrew CocoaPods"
}

# Function to verify CocoaPods installation
verify_cocoapods() {
    echo "🔍 Verifying CocoaPods installation..."
    
    local pod_path=$(which pod)
    local pod_version=$(pod --version 2>/dev/null)
    
    if [ $? -eq 0 ]; then
        echo "✅ CocoaPods found at: $pod_path"
        echo "✅ CocoaPods version: $pod_version"
        return 0
    else
        echo "❌ CocoaPods not working properly"
        return 1
    fi
}

# Function to create module cache structure
create_module_cache() {
    echo "📁 Creating comprehensive module cache structure..."
    
    # Remove existing cache
    rm -rf ~/Library/Developer/Xcode/DerivedData/ModuleCache.noindex
    rm -rf ~/Library/Developer/Xcode/DerivedData/SDKStatCaches.noindex
    
    # Create base directory and session file
    mkdir -p ~/Library/Developer/Xcode/DerivedData/ModuleCache.noindex
    touch ~/Library/Developer/Xcode/DerivedData/ModuleCache.noindex/Session.modulevalidation
    
    # Create all known directories
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
    
    echo "✅ Module cache structure created"
}

# Function to clean and reinstall pods
clean_and_reinstall_pods() {
    echo "🧹 Cleaning and reinstalling pods..."
    
    cd /Users/techoriz/workspace/tuw
    
    # Flutter clean
    flutter clean
    flutter pub get
    
    # Clean iOS pods
    cd ios
    rm -rf Pods Podfile.lock .symlinks
    
    # Install pods with correct environment
    pod install
    
    echo "✅ Pods reinstalled successfully"
}

# Function to run Flutter with correct environment
run_flutter() {
    echo "🚀 Running Flutter with fixed environment..."
    
    cd /Users/techoriz/workspace/tuw
    
    # Run Flutter with correct PATH
    flutter run -d "iPhone 16 Pro Max Fixed"
}

# Main execution
echo "🚀 Starting Comprehensive CocoaPods Fix..."

# Step 1: Set environment
set_environment

# Step 2: Verify CocoaPods
if verify_cocoapods; then
    echo "✅ CocoaPods verification passed"
else
    echo "❌ CocoaPods verification failed - installing via Homebrew"
    brew install cocoapods
    set_environment
    verify_cocoapods
fi

# Step 3: Create module cache
create_module_cache

# Step 4: Clean and reinstall pods
clean_and_reinstall_pods

# Step 5: Run Flutter
echo "🎯 CocoaPods fix completed! Starting Flutter..."
run_flutter
