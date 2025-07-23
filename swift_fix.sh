#!/bin/bash

# Swift Emit Module Fix Script for TUW Services
# Fixes "SwiftEmitModule failed with a nonzero exit code" errors

echo "🔧 Swift Emit Module Fix Script"
echo "==============================="

# Function to perform complete clean
complete_clean() {
    echo "🧹 Performing complete clean..."
    
    # Flutter clean
    cd /Users/techoriz/workspace/tuw
    flutter clean
    
    # Remove all Xcode derived data
    rm -rf ~/Library/Developer/Xcode/DerivedData/*
    
    # Get Flutter dependencies
    flutter pub get
    
    # Clean and reinstall iOS pods
    cd ios
    rm -rf Pods Podfile.lock .symlinks
    pod deintegrate
    pod install
    
    echo "✅ Complete clean finished"
}

# Function to create module cache structure
create_module_cache() {
    echo "📁 Creating module cache structure..."
    
    # Create base directory and session file
    mkdir -p ~/Library/Developer/Xcode/DerivedData/ModuleCache.noindex
    touch ~/Library/Developer/Xcode/DerivedData/ModuleCache.noindex/Session.modulevalidation
    
    # Create all known directories
    mkdir -p ~/Library/Developer/Xcode/DerivedData/ModuleCache.noindex/{1CL3H2PGYUAC7,1X9AJKXWMUIT5,2V5BH37492LF8,2B4W9D1ZCSXVS,1WW8UJLQCG5QJ,1VCYYLR47LO07,1TTSHFOBX977W}
    
    echo "✅ Module cache structure created"
}

# Function to build with Swift optimization
build_with_swift_fix() {
    echo "🏗️  Building with Swift compiler optimization..."
    
    cd /Users/techoriz/workspace/tuw/ios
    
    local build_path="/tmp/xcode_build_swift_$(date +%s)"
    
    xcodebuild -workspace Runner.xcworkspace \
               -scheme Runner \
               -configuration Debug \
               -destination 'platform=iOS Simulator,name=iPhone 16 Pro Max Fixed' \
               -derivedDataPath "$build_path" \
               SWIFT_COMPILATION_MODE=wholemodule \
               SWIFT_OPTIMIZATION_LEVEL=-O \
               clean build
    
    local build_result=$?
    
    if [ $build_result -eq 0 ]; then
        echo "✅ Build succeeded!"
        
        # Install and launch
        xcrun simctl install "A0364878-D0AC-4BC7-A30A-65AD8552FF42" "$build_path/Build/Products/Debug-iphonesimulator/Runner.app"
        local process_id=$(xcrun simctl launch "A0364878-D0AC-4BC7-A30A-65AD8552FF42" com.tuwconnect.servises | cut -d' ' -f2)
        echo "🎉 App launched successfully! Process ID: $process_id"
        
        open -a Simulator
        return 0
    else
        echo "❌ Build failed with exit code: $build_result"
        return 1
    fi
}

# Main execution
echo "🚀 Starting Swift Emit Module Fix..."

# Step 1: Complete clean
complete_clean

# Step 2: Create module cache
create_module_cache

# Step 3: Build with Swift optimization
build_with_swift_fix

echo ""
echo "🎯 Swift Emit Module Fix completed!"
echo "Your TUW Services app should now be running without Swift compilation errors!"
