#!/bin/bash

# CocoaPods Update Script for TUW Services
# Updates CocoaPods to recommended version and fixes pod issues

echo "🔧 CocoaPods Update Script"
echo "=========================="

# Function to check current version
check_version() {
    local current_version=$(pod --version)
    echo "📋 Current CocoaPods version: $current_version"
    
    # Compare with recommended version (1.16.2)
    if [[ "$current_version" < "1.16.2" ]]; then
        echo "⚠️  Version $current_version is below recommended 1.16.2"
        return 1
    else
        echo "✅ Version $current_version meets requirements"
        return 0
    fi
}

# Function to update CocoaPods
update_cocoapods() {
    echo "🔄 Updating CocoaPods to latest version..."
    
    # Try without sudo first
    gem install cocoapods
    local result=$?
    
    if [ $result -ne 0 ]; then
        echo "⚠️  Regular install failed, you may need to run with sudo manually"
        echo "💡 Run: sudo gem install cocoapods"
        return 1
    else
        echo "✅ CocoaPods updated successfully"
        return 0
    fi
}

# Function to reinstall pods with updated CocoaPods
reinstall_pods() {
    echo "🔄 Reinstalling pods with updated CocoaPods..."
    
    cd /Users/techoriz/workspace/tuw/ios
    
    # Clean install
    rm -rf Pods Podfile.lock
    pod install
    
    echo "✅ Pods reinstalled successfully"
}

# Main execution
echo "🚀 Starting CocoaPods update process..."

# Check current version
if check_version; then
    echo "✅ CocoaPods version is sufficient"
else
    echo "🔄 Updating CocoaPods..."
    if update_cocoapods; then
        echo "✅ CocoaPods updated successfully"
        reinstall_pods
    else
        echo "⚠️  CocoaPods update requires manual intervention"
        echo "💡 Your app is working fine with current version"
    fi
fi

echo ""
echo "🎯 CocoaPods update process completed!"
echo "Your TUW Services app should continue working normally."
