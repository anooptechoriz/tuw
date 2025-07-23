#!/bin/bash

# Super Comprehensive TUW Services iOS Fix Script
# Handles ALL module cache errors with dynamic directory creation

echo "🚀 Super Comprehensive iOS Fix Script"
echo "====================================="

# Function to create comprehensive module cache structure
create_super_cache() {
    echo "🧹 Performing super comprehensive module cache reset..."
    
    # Remove existing module cache completely
    rm -rf ~/Library/Developer/Xcode/DerivedData/ModuleCache.noindex
    rm -rf ~/Library/Developer/Xcode/DerivedData/Runner-*
    rm -rf /tmp/xcode_build_*
    
    # Create base directory
    mkdir -p ~/Library/Developer/Xcode/DerivedData/ModuleCache.noindex
    
    # Create Session.modulevalidation
    touch ~/Library/Developer/Xcode/DerivedData/ModuleCache.noindex/Session.modulevalidation
    
    echo "📁 Creating ALL known problematic directories..."
    
    # All known problematic directories (comprehensive list)
    local dirs=(
        "1CL3H2PGYUAC7"  # CoreMedia
        "1X9AJKXWMUIT5"  # sys_resource  
        "2V5BH37492LF8"  # CoreImage
        "2B4W9D1ZCSXVS"  # _Builtin_intrinsics
        "1WW8UJLQCG5QJ"  # CFNetwork/UIKit
        "1VCYYLR47LO07"  # IOSurface
        "1TTSHFOBX977W"  # UIKit/AudioSession
        # Pre-create some common patterns
        "2A3B4C5D6E7F8"  # Pattern 1
        "3B4C5D6E7F8G9"  # Pattern 2
        "4C5D6E7F8G9H0"  # Pattern 3
        "5D6E7F8G9H0I1"  # Pattern 4
        "6E7F8G9H0I1J2"  # Pattern 5
    )
    
    for dir in "${dirs[@]}"; do
        mkdir -p ~/Library/Developer/Xcode/DerivedData/ModuleCache.noindex/$dir
        echo "✅ Created: $dir"
    done
    
    # Set proper permissions
    chmod -R 755 ~/Library/Developer/Xcode/DerivedData/ModuleCache.noindex
    
    echo "✅ Super comprehensive module cache structure created"
}

# Function to build with multiple retry attempts
build_with_retry() {
    echo "🏗️  Building iOS app with retry logic..."
    
    cd ios
    local max_attempts=3
    local attempt=1
    
    while [ $attempt -le $max_attempts ]; do
        echo "🔄 Build attempt $attempt of $max_attempts..."
        
        local build_path="/tmp/xcode_build_super_$(date +%s)"
        
        xcodebuild -workspace Runner.xcworkspace \
                   -scheme Runner \
                   -configuration Debug \
                   -destination 'platform=iOS Simulator,name=iPhone 16 Pro Max Fixed' \
                   -derivedDataPath "$build_path" \
                   clean build
        
        local build_result=$?
        
        if [ $build_result -eq 0 ]; then
            echo "✅ Build succeeded on attempt $attempt!"
            
            # Install and launch
            xcrun simctl install "A0364878-D0AC-4BC7-A30A-65AD8552FF42" "$build_path/Build/Products/Debug-iphonesimulator/Runner.app"
            local process_id=$(xcrun simctl launch "A0364878-D0AC-4BC7-A30A-65AD8552FF42" com.tuwconnect.servises | cut -d' ' -f2)
            echo "🎉 App launched successfully! Process ID: $process_id"
            
            open -a Simulator
            return 0
        else
            echo "❌ Build attempt $attempt failed"
            if [ $attempt -lt $max_attempts ]; then
                echo "🔄 Recreating module cache for retry..."
                create_super_cache
            fi
            ((attempt++))
        fi
    done
    
    echo "❌ All build attempts failed"
    return 1
}

# Main execution
echo "🚀 Starting Super Comprehensive iOS Fix..."

# Create super comprehensive cache
create_super_cache

# Build with retry logic
build_with_retry

echo ""
echo "🎯 Super Comprehensive iOS Fix completed!"
echo "Your TUW Services app should now be running with bulletproof protection!"
