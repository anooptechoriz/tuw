#!/bin/bash

# Final Comprehensive iOS Fix Script for TUW Services
# Handles all CocoaPods, module cache, and build issues

echo "🔧 Final Comprehensive iOS Fix Script"
echo "====================================="

# Function to set correct environment
set_environment() {
    echo "🌍 Setting correct environment..."
    export PATH="/opt/homebrew/bin:$PATH"
    unset RBENV_VERSION
    unset RBENV_ROOT
    export COCOAPODS_DISABLE_STATS=true
    echo "✅ Environment configured"
}

# Function to verify CocoaPods
verify_cocoapods() {
    echo "🔍 Verifying CocoaPods..."
    local pod_version=$(pod --version 2>/dev/null)
    if [ $? -eq 0 ]; then
        echo "✅ CocoaPods version: $pod_version"
        return 0
    else
        echo "❌ CocoaPods not working, installing..."
        brew install cocoapods
        return $?
    fi
}

# Function to create module cache
create_module_cache() {
    echo "📁 Creating module cache structure..."
    rm -rf ~/Library/Developer/Xcode/DerivedData/ModuleCache.noindex
    rm -rf ~/Library/Developer/Xcode/DerivedData/SDKStatCaches.noindex
    
    mkdir -p ~/Library/Developer/Xcode/DerivedData/ModuleCache.noindex
    touch ~/Library/Developer/Xcode/DerivedData/ModuleCache.noindex/Session.modulevalidation
    
    local dirs=("1CL3H2PGYUAC7" "1X9AJKXWMUIT5" "2V5BH37492LF8" "2B4W9D1ZCSXVS" "1WW8UJLQCG5QJ" "1VCYYLR47LO07" "1TTSHFOBX977W")
    for dir in "${dirs[@]}"; do
        mkdir -p ~/Library/Developer/Xcode/DerivedData/ModuleCache.noindex/$dir
    done
    echo "✅ Module cache created"
}

# Function to clean and build
clean_and_build() {
    echo "🧹 Cleaning and building..."
    cd /Users/techoriz/workspace/tuw
    
    flutter clean
    flutter pub get
    
    cd ios
    rm -rf Pods Podfile.lock
    pod install
    
    echo "🏗️  Building with Xcode..."
    xcodebuild -workspace Runner.xcworkspace \
               -scheme Runner \
               -configuration Debug \
               -destination 'platform=iOS Simulator,name=iPhone 16' \
               -derivedDataPath /tmp/xcode_build_$(date +%s) \
               clean build
    
    local build_result=$?
    if [ $build_result -eq 0 ]; then
        echo "✅ Build succeeded!"
        
        # Install and launch
        local build_path=$(ls -t /tmp/xcode_build_* | head -1)
        xcrun simctl install "E955C56C-3F8D-4E9B-B96D-7E80B18ECC9C" "$build_path/Build/Products/Debug-iphonesimulator/Runner.app"
        local process_id=$(xcrun simctl launch "E955C56C-3F8D-4E9B-B96D-7E80B18ECC9C" com.tuwconnect.servises | cut -d' ' -f2)
        echo "🎉 App launched! Process ID: $process_id"
        
        open -a Simulator
        return 0
    else
        echo "❌ Build failed"
        return 1
    fi
}

# Main execution
echo "🚀 Starting Final iOS Fix..."

set_environment
verify_cocoapods
create_module_cache
clean_and_build

echo "🎯 Final iOS Fix completed!"
